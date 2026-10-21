#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 1024//512

void matmul(double * __restrict a, double * __restrict b, double * __restrict c) {
    const int n = 1024;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            for (int k = 0; k < n; k++) {
                c[i*n + j] += a[i*n + k] * b[k*n + j];
            }
        }
    }
}

int main(void) {
    double *A = malloc(N * N * sizeof(double));
    double *B = malloc(N * N * sizeof(double));
    double *C = malloc(N * N * sizeof(double));
    
    srand(42);
    for (int i = 0; i < N * N; i++) {
        A[i] = (double)rand() / RAND_MAX;
        B[i] = (double)rand() / RAND_MAX;
        C[i] = 0.0;
    }

    clock_t start = clock();
    matmul(A, B, C); // ,N)
    clock_t end = clock();

    double elapsed = (double)(end - start) / CLOCKS_PER_SEC;
    printf("matmul %dx%d: %.3f s\n", N, N, elapsed);
    printf("checksum: %f\n", C[(N/2)*N + N/2]);
    
    free(A); free(B); free(C);
    return 0;
}