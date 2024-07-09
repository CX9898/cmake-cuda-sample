#pragma once

template<typename T>
__global__ void vecAdd(const int n, const T *a, const T *b, T *c);
