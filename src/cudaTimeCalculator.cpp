#include "cudaTimeCalculator.hpp"
#include "cudaErrorCheck.cuh"

cudaTimeCalculator::cudaTimeCalculator(){
    _time = 0.0f;

    cudaErrCheck(cudaEventCreate(&_star));
    cudaErrCheck(cudaEventCreate(&_stop));
}

cudaTimeCalculator::~cudaTimeCalculator() {
    cudaErrCheck(cudaEventDestroy(_star));
    cudaErrCheck(cudaEventDestroy(_stop));
}

void cudaTimeCalculator::startClock() {
    cudaErrCheck(cudaEventRecord(_star));
}

void cudaTimeCalculator::endClock() {
    cudaErrCheck(cudaEventRecord(_stop));
    cudaErrCheck(cudaEventSynchronize(_stop));
}

float cudaTimeCalculator::getTime() {
    cudaErrCheck(cudaEventElapsedTime(&_time, _star, _stop));
    return _time;
}