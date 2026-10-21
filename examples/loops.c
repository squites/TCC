// loops.c
//#include <stdio.h>
#include <math.h>

#define N 256

// LICM
void test_licm(float *a, float base, float fator, int n) {
    for (int i = 0; i < n; i++)
        a[i] = a[i] + base * fator;
}

// ---------------------------------------------------
// 2. LICM bloqueado — chamada de função não pura
//    O LLVM NAO move sqrt para fora mesmo sendo invariante
//    Isso é exatamente a limitação que o professor apontou
// ---------------------------------------------------
void test_licm_blocked(float *a, float x, int n) {
    for (int i = 0; i < n; i++)
        a[i] = a[i] + sqrt(x);  // x nao muda, mas LLVM nao sabe se sqrt tem side effects
}

// loop unswitch
void test_unswitch(float *a, float *b, int n, int modo) {
    for (int i = 0; i < n; i++) {
        if (modo == 0)          // modo nao muda — invariante
            a[i] = b[i] * 2.0f;
        else
            a[i] = b[i] + 2.0f;
    }
}

// loop vectorize
void test_vectorize(float *a, float *b, float *c, int n) {
    for (int i = 0; i < n; i++)
        c[i] = a[i] + b[i];
}

// loop interchange
void test_interchange(float a[N][N], float b[N][N]) {
    for (int j = 0; j < N; j++)       // j no externo = column-major = cache miss
        for (int i = 0; i < N; i++)
            b[i][j] = a[i][j] * 2.0f;
}

// loop tiling
void test_tiling(float a[N][N], float b[N][N], float c[N][N]) {
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            for (int k = 0; k < N; k++)
                c[i][j] += a[i][k] * b[k][j];
}

// loop deletion
void test_deletion(int n) {
    int soma = 0;
    for (int i = 0; i < n; i++)
        soma += i;              // soma nunca retornada nem usada
    // resultado morto — loop deve ser eliminado
}

// loop unroll
void test_unroll(float *a, float *b) {
    for (int i = 0; i < 8; i++)   // trip count fixo e pequeno
        a[i] = b[i] * 3.14f;
}

// loop reduction
float test_reduction(float *a, int n) {
    float soma = 0.0f;
    for (int i = 0; i < n; i++)
        soma += a[i];
    return soma;
}

int main() {
    float a[N], b[N], c[N];
    float mat_a[N][N], mat_b[N][N], mat_c[N][N];

    test_licm(a, 2.0f, 3.0f, N);
    test_licm_blocked(a, 4.0f, N);
    test_unswitch(a, b, N, 0);
    test_vectorize(a, b, c, N);
    //test_vectorize_blocked(c, N);
    test_interchange(mat_a, mat_b);
    test_tiling(mat_a, mat_b, mat_c);
    test_deletion(N);
    test_unroll(a, b);
    float r = test_reduction(a, N);

    //printf("resultado: %f\n", r);
    return 0;
}