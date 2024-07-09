#include "kernel.cuh"
#include <cuda_fp16.h>

template<typename T>
__global__ void vecAdd(const int n, const T *a, const T *b, T *c) {
    const int tid = blockDim.x * blockIdx.x + threadIdx.x;
    if (tid >= n) {
        return;
    }

    c[tid] = a[tid] + b[tid];
}

template __global__ void vecAdd<float>(const int, const float*, const float*, float*);
template __global__ void vecAdd<double>(const int, const double*, const double*, double*);
template __global__ void vecAdd<half>(const int, const half*, const half*, half*);