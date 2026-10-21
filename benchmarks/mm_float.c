#include <stdio.h>

#define N 1024

float A[N][N];
float B[N][N];
float C[N][N];

void init() {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            A[i][j] = (float)(i + j);
            B[i][j] = (float)(i - j);
            C[i][j] = 0.0f;
        }
    }
}

void matmul() {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < N; j++) {
            for (int k = 0; k < N; k++) {
                C[i][j] += A[i][k] * B[k][j];
            }
        }
    }
}

int main() {
    init();
    matmul();
    printf("%f\n", C[0][0]);
    return 0;
}