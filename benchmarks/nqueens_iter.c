#include <stdio.h>
#include <time.h>

#define N 14

static int pos[N]; /* pos[r] = column of queen in row r */
static long count;

/* iterative backtracking with explicit stack (pos[] + row pointer) */
void solve(void)
{
    int row = 0;
    pos[0] = 0;

    while (row >= 0) {
        if (row == N) {
            count++;
            row--;
            pos[row]++;
            continue;
        }

        /* find next valid column for this row */
        int placed = 0;
        for (; pos[row] < N; pos[row]++) {
            int ok = 1;
            for (int r = 0; r < row; r++) {
                int d = row - r;
                if (pos[r] == pos[row] ||
                    pos[r] == pos[row] - d ||
                    pos[r] == pos[row] + d) {
                    ok = 0;
                    break;
                }
            }
            if (ok) {
                placed = 1;
                break;
            }
        }

        if (placed) {
            row++;
            if (row < N)
                pos[row] = 0;
        } else {
            row--;
            if (row >= 0)
                pos[row]++;
        }
    }
}

int main(void)
{
    clock_t start = clock();
    solve();
    clock_t end = clock();

    double elapsed = (double)(end - start) / CLOCKS_PER_SEC;
    printf("nqueens_iter %d: %ld solutions in %.3f s\n", N, count, elapsed);

    return 0;
}
