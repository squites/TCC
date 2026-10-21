/* driver.c — laço externo para dar duração suficiente à amostragem dinâmica.
 *
 * O mperf amostra contadores a cada ~1ms e o powermetrics precisa de ~1s+ de
 * janela; benchmarks como o matmul rodam em milissegundos. Este driver chama
 * kernel_main() N vezes (N via argv[1], default 1) dentro do mesmo processo.
 *
 * A IR do benchmark é compilada com -Dmain=kernel_main, então o main original
 * vira uma função chamável — sem alterar o código medido.
 */
//#include <stdlib.h>
//
//extern int kernel_main(void);
//
//int main(int argc, char **argv) {
//    int n = (argc > 1) ? atoi(argv[1]) : 1;
//    int r = 0;
//    for (int i = 0; i < n; i++)
//        r |= kernel_main();
//    return r;
//}

/* driver.c — executa kernel_main() N vezes e mede a energia via IOReport.
 *
 * Uso:
 *   ./bin N              executa N vezes, sem medir energia (verificação/calibração)
 *   ./bin N arquivo.txt  mede energia em repouso (1 s) e durante as N execuções,
 *                        e grava os contadores do grupo "Energy Model" no arquivo
 *
 * A IR do benchmark é compilada com -Dmain=kernel_main, então o main original
 * vira uma função chamável — sem alterar o código medido.
 *
 * Ligação: -framework CoreFoundation -lIOReport
 */
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <math.h>
#include <time.h>
#include <unistd.h>
#include <CoreFoundation/CoreFoundation.h>

extern int kernel_main(void);

/* ---- API privada do IOReport (libIOReport.dylib), sem header público ---- */
typedef struct IOReportSubscription *IOReportSubscriptionRef;
extern CFDictionaryRef IOReportCopyChannelsInGroup(CFStringRef group, CFStringRef subgroup,
                                                   uint64_t a, uint64_t b, uint64_t c);
extern IOReportSubscriptionRef IOReportCreateSubscription(void *a, CFMutableDictionaryRef desired,
                                                          CFMutableDictionaryRef *subbed,
                                                          uint64_t channel_id, CFTypeRef b);
extern CFDictionaryRef IOReportCreateSamples(IOReportSubscriptionRef sub,
                                             CFMutableDictionaryRef subbed, CFTypeRef a);
extern CFDictionaryRef IOReportCreateSamplesDelta(CFDictionaryRef prev, CFDictionaryRef cur,
                                                  CFTypeRef a);
extern int64_t IOReportSimpleGetIntegerValue(CFDictionaryRef item, int32_t idx);
extern CFStringRef IOReportChannelGetChannelName(CFDictionaryRef item);
extern CFStringRef IOReportChannelGetUnitLabel(CFDictionaryRef item);

static IOReportSubscriptionRef assinatura;
static CFMutableDictionaryRef canais_assinados;

/* Assina todos os canais do grupo "Energy Model". */
static int ioreport_iniciar(void) {
    CFDictionaryRef canais = IOReportCopyChannelsInGroup(CFSTR("Energy Model"), NULL, 0, 0, 0);
    if (!canais) return -1;
    CFMutableDictionaryRef desejados =
        CFDictionaryCreateMutableCopy(kCFAllocatorDefault, CFDictionaryGetCount(canais), canais);
    CFRelease(canais);
    assinatura = IOReportCreateSubscription(NULL, desejados, &canais_assinados, 0, NULL);
    CFRelease(desejados);
    return assinatura ? 0 : -1;
}

/* Amostra o valor atual de todos os contadores cumulativos. */
static CFDictionaryRef amostrar(void) {
    return IOReportCreateSamples(assinatura, canais_assinados, NULL);
}

/* Converte o valor bruto para joules, segundo a unidade informada pelo canal. */
static double para_joules(int64_t valor, CFStringRef unidade) {
    char u[16] = "";
    if (unidade) CFStringGetCString(unidade, u, sizeof u, kCFStringEncodingUTF8);
    if (strcmp(u, "mJ") == 0) return valor / 1e3;
    if (strcmp(u, "uJ") == 0 || strcmp(u, "\u00b5J") == 0) return valor / 1e6;
    if (strcmp(u, "nJ") == 0) return valor / 1e9;
    return NAN;  /* unidade desconhecida */
}

static CFArrayRef lista_de_canais(CFDictionaryRef amostra) {
    return (CFArrayRef)CFDictionaryGetValue(amostra, CFSTR("IOReportChannels"));
}

static double agora(void) {
    struct timespec ts;
    clock_gettime(CLOCK_MONOTONIC, &ts);
    return ts.tv_sec + ts.tv_nsec / 1e9;
}

int main(int argc, char **argv) {
    int n = (argc > 1) ? atoi(argv[1]) : 1;
    const char *arquivo = (argc > 2) ? argv[2] : NULL;
    int r = 0;

    /* sem arquivo: comportamento original, sem medir energia */
    if (!arquivo) {
        for (int i = 0; i < n; i++) r |= kernel_main();
        return r;
    }

    if (ioreport_iniciar() != 0) {
        fprintf(stderr, "driver: IOReport indisponível\n");
        return 2;
    }

    /* 1. repouso: energia do sistema parado durante 1 s */
    CFDictionaryRef r0 = amostrar();
    double tr0 = agora();
    sleep(3);
    double tr1 = agora();
    CFDictionaryRef r1 = amostrar();

    /* 2. kernel: energia durante as N execuções */
    CFDictionaryRef k0 = amostrar();
    double tk0 = agora();
    for (int i = 0; i < n; i++) r |= kernel_main();
    double tk1 = agora();
    CFDictionaryRef k1 = amostrar();

    CFDictionaryRef d_rep = IOReportCreateSamplesDelta(r0, r1, NULL);
    CFDictionaryRef d_ker = IOReportCreateSamplesDelta(k0, k1, NULL);

    FILE *f = fopen(arquivo, "w");
    if (!f) { perror("driver: fopen"); return 2; }
    fprintf(f, "# repouso_s=%.6f kernel_s=%.6f N=%d\n", tr1 - tr0, tk1 - tk0, n);
    fprintf(f, "canal\tunidade\trepouso_J\tkernel_J\n");

    /* mesma assinatura -> mesma ordem de canais nos dois deltas */
    CFArrayRef cr = lista_de_canais(d_rep), ck = lista_de_canais(d_ker);
    CFIndex total = CFArrayGetCount(ck);
    for (CFIndex i = 0; i < total && i < CFArrayGetCount(cr); i++) {
        CFDictionaryRef ir = CFArrayGetValueAtIndex(cr, i);
        CFDictionaryRef ik = CFArrayGetValueAtIndex(ck, i);
        char nome[128] = "", unid[16] = "";
        CFStringRef cn = IOReportChannelGetChannelName(ik);
        CFStringRef cu = IOReportChannelGetUnitLabel(ik);
        if (cn) CFStringGetCString(cn, nome, sizeof nome, kCFStringEncodingUTF8);
        if (cu) CFStringGetCString(cu, unid, sizeof unid, kCFStringEncodingUTF8);
        double jr = para_joules(IOReportSimpleGetIntegerValue(ir, 0), cu);
        double jk = para_joules(IOReportSimpleGetIntegerValue(ik, 0), cu);
        fprintf(f, "%s\t%s\t%.9f\t%.9f\n", nome, unid, jr, jk);
    }
    fclose(f);
    return r;
}
