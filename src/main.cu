#include <iostream>
#include "host.hpp"
#include "kernel.cuh"
#include "helper_cuda.h"

#define MATRIX_M 1024
#define MATRIX_N 1024
#define MATRIX_K 1024

int main() {
    float aHost;
    float bHost;
    float cHost;

    float *aDev;
    float *bDev;
    float *cDev;

    checkCudaErrors(cudaMalloc((void **) &aDev, MATRIX_M * MATRIX_K * sizeof(float)));
    checkCudaErrors(cudaMalloc((void **) &bDev, MATRIX_K * MATRIX_N * sizeof(float)));
    checkCudaErrors(cudaMalloc((void **) &cDev, MATRIX_M * MATRIX_N * sizeof(float)));


    return 0;
}
