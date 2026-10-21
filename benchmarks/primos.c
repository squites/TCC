#include <stdio.h>
#include <stdlib.h>

#define LIMITE 100000

int primos[LIMITE];

int eh_primo(int n) {
    if (n < 2) return 0;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return 0;
    }
    return 1;
}

int main() {
    int count = 0;
    for (int n = 2; n < LIMITE; n++) {
        if (eh_primo(n)) {
            primos[count++] = n;
        }
    }
    printf("Total de primos: %d\n", count);
    return 0;
}
