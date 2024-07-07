#include <iostream>
#include "host.hpp"
#include "kernel.cuh"

#define MATRIX_M 1024
#define MATRIX_N 1024
#define MATRIX_K 1024

#define cudaErrCheck(stat) { cudaErrCheck_((stat), __FILE__, __LINE__); }
void cudaErrCheck_(cudaError_t stat, const char *file, int line) {
    if (stat != cudaSuccess) {
        fprintf(stderr, "CUDA Error: %s %s %d\n", cudaGetErrorString(stat), file, line);
    }
}

int main() {
    float *A;
    float *B;
    float *C;

    cudaErrCheck(cudaMalloc((void **) &a_fp32, MATRIX_M * MATRIX_K * sizeof(float)));
    A = (float *) malloc(MATRIX_M * MATRIX_K * sizeof(float));
    B = (float *) malloc(MATRIX_K * MATRIX_N * sizeof(float));
    B = (float *) malloc(MATRIX_K * MATRIX_N * sizeof(float));

#pragma omp parallel for
    for (int i = 0; i < 100; ++i) {
        std::cout << i << std::endl;
    }

    return 0;
}
