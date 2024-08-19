#pragma once

#include <cstdio>
#include <cuda_runtime.h>

namespace cudaTimeCalculator {
void cudaErrCheck_(cudaError_t stat) {
    if (stat != cudaSuccess) {
        fprintf(stderr, "CudaTimeCalculator Error: %s \n", cudaGetErrorString(stat));
    }
}
} // namespace cudaTimeCalculator

class CudaTimeCalculator {
 public:
  CudaTimeCalculator() {
      time_ = 0.0f;

      cudaTimeCalculator::cudaErrCheck_(cudaEventCreate(&star_));
      cudaTimeCalculator::cudaErrCheck_(cudaEventCreate(&stop_));
  }

  ~CudaTimeCalculator() {
      cudaTimeCalculator::cudaErrCheck_(cudaEventDestroy(star_));
      cudaTimeCalculator::cudaErrCheck_(cudaEventDestroy(stop_));
  }

  void reset(){
      cudaTimeCalculator::cudaErrCheck_(cudaEventDestroy(star_));
      cudaTimeCalculator::cudaErrCheck_(cudaEventDestroy(stop_));

      cudaTimeCalculator::cudaErrCheck_(cudaEventCreate(&star_));
      cudaTimeCalculator::cudaErrCheck_(cudaEventCreate(&stop_));
  }

  void startClock() {
      cudaTimeCalculator::cudaErrCheck_(cudaEventRecord(star_));
  }

  void endClock() {
      cudaTimeCalculator::cudaErrCheck_(cudaEventRecord(stop_));
      cudaTimeCalculator::cudaErrCheck_(cudaEventSynchronize(stop_));
  }

  float getTime() {
      cudaTimeCalculator::cudaErrCheck_(cudaEventElapsedTime(&time_, star_, stop_));
      return time_;
  }

 private:
  cudaEvent_t star_;
  cudaEvent_t stop_;

  float time_;
};

