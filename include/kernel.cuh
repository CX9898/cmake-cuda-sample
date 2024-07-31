#pragma once

/**
 * This is a simple example of vector addition on GPU devices.
 * Supporting half, float,double, and int types.
 **/
template<typename T>
__global__ void vecAdd(const int n, const T *vecA, const T *vecB, T *result);
