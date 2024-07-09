#include <cstdio>

#include "kernel.cuh"
#include "helper_cuda.h"

#define VEC_SIZE 1048576

int main() {
    float *a;
    float *b;
    float *c;

    checkCudaErrors(cudaMalloc((void **) &a, VEC_SIZE * sizeof(float)));
    checkCudaErrors(cudaMalloc((void **) &b, VEC_SIZE * sizeof(float)));
    checkCudaErrors(cudaMalloc((void **) &c, VEC_SIZE * sizeof(float)));

    cudaEvent_t star, stop;
    checkCudaErrors(cudaEventCreate(&star));
    checkCudaErrors(cudaEventCreate(&stop));

    const int numThreadPerBlocks = 1024;
    const int numBlocks = (VEC_SIZE + numThreadPerBlocks - 1) / numThreadPerBlocks;

    checkCudaErrors(cudaEventRecord(star));
    vecAdd<float><<<numBlocks, numThreadPerBlocks>>>(VEC_SIZE, a, b, c);
    checkCudaErrors(cudaEventRecord(stop));
    cudaDeviceSynchronize();

    float time;
    checkCudaErrors(cudaEventElapsedTime(&time, star, stop));

    printf("time : %fms\n", time);

    checkCudaErrors(cudaEventDestroy(star));
    checkCudaErrors(cudaEventDestroy(stop));

    cudaFree(a);
    cudaFree(b);
    cudaFree(c);

    return 0;
}
