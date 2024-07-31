#include <cstdio>

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

    cudaEvent_t star, stop;
    cudaErrCheck(cudaEventCreate(&star));
    cudaErrCheck(cudaEventCreate(&stop));

    const int numThreadPerBlocks = 1024;
    const int numBlocks = (VEC_SIZE + numThreadPerBlocks - 1) / numThreadPerBlocks;

    cudaErrCheck(cudaEventRecord(star));
    vecAdd<float><<<numBlocks, numThreadPerBlocks>>>(VEC_SIZE, vecA, vecB, vecC);
    cudaErrCheck(cudaEventRecord(stop));
    cudaDeviceSynchronize();

    float time;
    cudaErrCheck(cudaEventElapsedTime(&time, star, stop));

    printf("VEC_SIZE : %d\n"
           "vecAdd Function time : %fms\n", VEC_SIZE, time);

    cudaErrCheck(cudaEventDestroy(star));
    cudaErrCheck(cudaEventDestroy(stop));

    cudaErrCheck(cudaFree(vecA));
    cudaErrCheck(cudaFree(vecB));
    cudaErrCheck(cudaFree(vecC));

    return 0;
}
