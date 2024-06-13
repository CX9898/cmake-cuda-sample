#include <iostream>
#include "head.hpp"

int main() {
    float *A;
    float *B;

    A = (float *) malloc(MATRIX_SIZE * sizeof(float));

#pragma omp parallel for
    for (int i = 0; i < 100; ++i) {
        std::cout << i << std::endl;
    }

    return 0;
}
