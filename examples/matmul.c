#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 32

double A[N][N];
double B[N][N];
double C[N][N];

void matmul() {
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++)
            for (int k = 0; k < N; k++)
                C[i][j] += A[i][k] * B[k][j];
}

void init() {
    for (int i = 0; i < N; i++)
        for (int j = 0; j < N; j++) {
            A[i][j] = (double)rand() / RAND_MAX;
            B[i][j] = (double)rand() / RAND_MAX;
            C[i][j] = 0.0;
        }
}

// implement multiple loops optimizations !
// void loop_fusion();
// void loop_fission();
// void 

int main() {
    srand(42);
    init();

    clock_t start = clock();
    matmul();
    clock_t end = clock();

    double elapsed = (double)(end - start) / CLOCKS_PER_SEC;
    printf("Tempo: %.4f segundos\n", elapsed);

    printf("C[0][0] = %.6f\n", C[0][0]);

    return 0;
}