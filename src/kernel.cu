#include <cuda_fp16.h>

#include "kernel.cuh"

template<typename T>
__global__ void vecAdd(const int n, const T *vecA, const T *vecB, T *result) {
    const int tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= n) {
        return;
    }

    result[tid] = vecA[tid] + vecB[tid];
}

template __global__ void vecAdd<half>(const int, const half *, const half *, half *);
template __global__ void vecAdd<float>(const int, const float *, const float *, float *);
template __global__ void vecAdd<double>(const int, const double *, const double *, double *);
template __global__ void vecAdd<int>(const int, const int *, const int *, int *);