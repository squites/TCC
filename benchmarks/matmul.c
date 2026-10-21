#include <stdio.h>
#include <stdlib.h>
#include <time.h>

#define N 512

static double a[N][N];
static double b[N][N];
//static double c[N][N];
static volatile double c[N][N];

void matmul(void)
{
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            // double sum = 0.0; // essa variavel local otimiza o código, evitando loads em cada iteraçao
            for (int k = 0; k < N; k++) {
                //sum += a[i][k] * b[k][j];
                c[i][j] += a[i][k] * b[k][j];
            }
            //c[i][j] = sum;
        }
    }
}

int main(void)
{
    srand(42);
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            a[i][j] = (double)rand() / RAND_MAX;
            b[i][j] = (double)rand() / RAND_MAX;
        }
    }

    clock_t start = clock();
    matmul();
    clock_t end = clock();

    double elapsed = (double)(end - start) / CLOCKS_PER_SEC;
    double gflops = 2.0 * N * N * N / elapsed / 1e9;

    printf("matmul %dx%d: %.3f s (%.2f GFLOP/s)\n", N, N, elapsed, gflops);
    printf("checksum: %f\n", c[N / 2][N / 2]);

    return 0;
}
