#include <stdio.h>
#include <time.h>

#define N 14

static int col[N];
static int diag1[2 * N]; /* row + col */
static int diag2[2 * N]; /* row - col + N - 1 */
static long count;

void solve(int row)
{
    if (row == N) {
        count++;
        return;
    }
    for (int j = 0; j < N; j++) {
        if (col[j] || diag1[row + j] || diag2[row - j + N - 1])
            continue;
        col[j] = diag1[row + j] = diag2[row - j + N - 1] = 1;
        solve(row + 1);
        col[j] = diag1[row + j] = diag2[row - j + N - 1] = 0;
    }
}

int main(void)
{
    clock_t start = clock();
    solve(0);
    clock_t end = clock();

    double elapsed = (double)(end - start) / CLOCKS_PER_SEC;
    printf("nqueens %d: %ld solutions in %.3f s\n", N, count, elapsed);

    return 0;
}
