// matmul_func.c
#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 1024

void matmul(double *a, double *b, double *c, double *fatores) {
    const int n = 1024;
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            for (int k = 0; k < n; k++) {
                // bloco invariante em k — deveria sair do loop
                double p1 = fatores[i] * fatores[j];
                double p2 = fatores[i] + fatores[j];
                double p3 = p1 * p2;
                double peso = p1 + p2 + p3;
                
                c[i*n + j] += a[i*n + k] * b[k*n + j] * peso;
            }
        }
    }
}

int main(void) {
    double *A = malloc(N * N * sizeof(double));
    double *B = malloc(N * N * sizeof(double));
    double *C = malloc(N * N * sizeof(double));
    double *fatores = malloc(N * sizeof(double));   // novo array

    srand(42);
    for (int i = 0; i < N * N; i++) {
        A[i] = (double)rand() / RAND_MAX;
        B[i] = (double)rand() / RAND_MAX;
        C[i] = 0.0;
    }
    for (int i = 0; i < N; i++) {                    // inicializa fatores      
        fatores[i] = (double)rand() / RAND_MAX;
    }
    matmul(A, B, C, fatores);
    printf("checksum: %f\n", C[(N/2)*N + N/2]);

    free(A); free(B); free(C); free(fatores);
    return 0;
}