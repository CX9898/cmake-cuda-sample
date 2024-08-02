#include <cstdio>

#include "CudaTimeCalculator.hpp"
#include "kernel.cuh"
#include "cudaErrorCheck.cuh"

#define VEC_SIZE 1048576

int main() {
    float *vecA;
    float *vecB;
    float *vecC;

    cudaErrCheck(cudaMalloc((void **) &vecA, VEC_SIZE * sizeof(float)));
    cudaErrCheck(cudaMalloc((void **) &vecB, VEC_SIZE * sizeof(float)));
    cudaErrCheck(cudaMalloc((void **) &vecC, VEC_SIZE * sizeof(float)));

    CudaTimeCalculator timeCalculator;

    const int numThreadPerBlocks = 1024;
    const int numBlocks = (VEC_SIZE + numThreadPerBlocks - 1) / numThreadPerBlocks;

    timeCalculator.startClock();
    vecAdd<float><<<numBlocks, numThreadPerBlocks>>>(VEC_SIZE, vecA, vecB, vecC);
    timeCalculator.endClock();

    printf("VEC_SIZE : %d\n"
           "vecAdd Function time : %fms\n", VEC_SIZE, timeCalculator.getTime());

    cudaErrCheck(cudaFree(vecA));
    cudaErrCheck(cudaFree(vecB));
    cudaErrCheck(cudaFree(vecC));

    return 0;
}
