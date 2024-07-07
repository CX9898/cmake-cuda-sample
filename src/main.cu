#include <iostream>
#include "host.hpp"
#include "kernel.cuh"
#include "helper_cuda.h"

#define MATRIX_M 1024
#define MATRIX_N 1024
#define MATRIX_K 1024

int main() {
    float *A;
    float *B;
    float *C;

    checkCudaErrors(cudaMalloc((void **) &A, MATRIX_M * MATRIX_K * sizeof(float)));
    checkCudaErrors(cudaMalloc((void **) &B, MATRIX_K * MATRIX_N * sizeof(float)));
    checkCudaErrors(cudaMalloc((void **) &C, MATRIX_M * MATRIX_N * sizeof(float)));


    return 0;
}
