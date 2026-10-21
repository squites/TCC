#include <stdio.h>
#include <time.h>

#define H 1024  /* image height */
#define W 1024  /* image width */
#define KH 3    /* kernel height */
#define KW 3    /* kernel width */
#define REPS 50 /* repetitions (for timing) */

static double in[H * W];
static double out[H * W];
static double kernel[KH * KW];

/* deterministic LCG for reproducible data (no rand() dependency) */
static unsigned long rng_state = 42;

static double frand(void)
{
    rng_state = rng_state * 6364136223846793005UL + 1442695040888963407UL;
    return (double)(rng_state >> 11) * (1.0 / 9007199254740992.0);
}

static void init(void)
{
    for (int i = 0; i < H * W; i++)
        in[i] = frand();
    for (int k = 0; k < KH * KW; k++)
        kernel[k] = frand();
}

/* valid (non-padded) 2D convolution:
   out[i][j] = sum_ki sum_kj in[i+ki][j+kj] * kernel[ki][kj] */
static void conv2d(void)
{
    for (int i = 0; i < H - KH + 1; i++) {
        for (int j = 0; j < W - KW + 1; j++) {
            double acc = 0.0;
            for (int ki = 0; ki < KH; ki++) {
                for (int kj = 0; kj < KW; kj++) {
                    acc += in[(i + ki) * W + (j + kj)] * kernel[ki * KW + kj];
                }
            }
            out[i * W + j] = acc;
        }
    }
}

int main(void)
{
    init();

    clock_t start = clock();
    for (int r = 0; r < REPS; r++)
        conv2d();
    clock_t end = clock();

    double elapsed = (double)(end - start) / CLOCKS_PER_SEC;

    double checksum = 0.0;
    for (int i = 0; i < H - KH + 1; i++)
        for (int j = 0; j < W - KW + 1; j++)
            checksum += out[i * W + j];

    printf("2d_conv %dx%d K=%dx%d reps=%d: %.3f s\n", H, W, KH, KW, REPS, elapsed);
    printf("checksum: %f\n", checksum);

    return 0;
}
