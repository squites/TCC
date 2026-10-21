#include <stdio.h>
#include <time.h>

#define N 1000000 /* signal length */
#define KSIZE 5   /* kernel size */
#define REPS 100  /* repetitions (for timing) */

static double in[N];
static double out[N];
static double kernel[KSIZE];

/* deterministic LCG for reproducible data (no rand() dependency) */
static unsigned long rng_state = 42;

static double frand(void)
{
    rng_state = rng_state * 6364136223846793005UL + 1442695040888963407UL;
    return (double)(rng_state >> 11) * (1.0 / 9007199254740992.0);
}

static void init(void)
{
    for (int i = 0; i < N; i++)
        in[i] = frand();
    for (int k = 0; k < KSIZE; k++)
        kernel[k] = frand();
}

/* valid (non-padded) 1D convolution: out[i] = sum_k in[i+k] * kernel[k] */
static void conv1d(void)
{
    for (int i = 0; i < N - KSIZE + 1; i++) {
        double acc = 0.0;
        for (int k = 0; k < KSIZE; k++) {
            acc += in[i + k] * kernel[k];
        }
        out[i] = acc;
    }
}

int main(void)
{
    init();

    clock_t start = clock();
    for (int r = 0; r < REPS; r++)
        conv1d();
    clock_t end = clock();

    double elapsed = (double)(end - start) / CLOCKS_PER_SEC;

    double checksum = 0.0;
    for (int i = 0; i < N - KSIZE + 1; i++)
        checksum += out[i];

    printf("1d_conv N=%d K=%d reps=%d: %.3f s\n", N, KSIZE, REPS, elapsed);
    printf("checksum: %f\n", checksum);

    return 0;
}
