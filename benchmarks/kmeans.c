#include <stdio.h>
#include <float.h>
#include <time.h>

#define NP 100000 /* number of points */
#define DIM 8     /* dimensions per point */
#define K 16      /* clusters */
#define ITER 20   /* fixed iterations */

static double points[NP * DIM];
static double centers[K * DIM];
static double sums[K * DIM];
static int assign[NP];
static int counts[K];

/* deterministic LCG for reproducible data (no rand() dependency) */
static unsigned long rng_state = 42;

static double frand(void)
{
    rng_state = rng_state * 6364136223846793005UL + 1442695040888963407UL;
    return (double)(rng_state >> 11) * (1.0 / 9007199254740992.0);
}

static void init(void)
{
    for (int i = 0; i < NP; i++)
        for (int d = 0; d < DIM; d++)
            points[i * DIM + d] = frand();

    /* centers start as the first K points */
    for (int k = 0; k < K; k++)
        for (int d = 0; d < DIM; d++)
            centers[k * DIM + d] = points[k * DIM + d];
}

/* assignment step: nearest center per point */
static void assign_clusters(void)
{
    for (int i = 0; i < NP; i++) {
        int best = 0;
        double best_dist = DBL_MAX;
        for (int k = 0; k < K; k++) {
            double dist = 0.0;
            for (int d = 0; d < DIM; d++) {
                double diff = points[i * DIM + d] - centers[k * DIM + d];
                dist += diff * diff;
            }
            if (dist < best_dist) {
                best_dist = dist;
                best = k;
            }
        }
        assign[i] = best;
    }
}

/* update step: recompute each center as the mean of its cluster */
static void update_centers(void)
{
    for (int k = 0; k < K; k++) {
        counts[k] = 0;
        for (int d = 0; d < DIM; d++)
            sums[k * DIM + d] = 0.0;
    }

    for (int i = 0; i < NP; i++) {
        int k = assign[i];
        counts[k]++;
        for (int d = 0; d < DIM; d++)
            sums[k * DIM + d] += points[i * DIM + d];
    }

    for (int k = 0; k < K; k++) {
        if (counts[k] == 0)
            continue; /* empty cluster keeps its old center */
        for (int d = 0; d < DIM; d++)
            centers[k * DIM + d] = sums[k * DIM + d] / counts[k];
    }
}

int main(void)
{
    init();

    clock_t start = clock();
    for (int it = 0; it < ITER; it++) {
        assign_clusters();
        update_centers();
    }
    clock_t end = clock();

    double elapsed = (double)(end - start) / CLOCKS_PER_SEC;

    double checksum = 0.0;
    for (int k = 0; k < K; k++)
        for (int d = 0; d < DIM; d++)
            checksum += centers[k * DIM + d];

    printf("kmeans N=%d K=%d iters=%d: %.3f s\n", NP, K, ITER, elapsed);
    printf("checksum: %f\n", checksum);

    return 0;
}
