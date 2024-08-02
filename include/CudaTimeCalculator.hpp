#pragma once

#include <cuda_runtime.h>

class CudaTimeCalculator {
 public:
  CudaTimeCalculator();
  ~CudaTimeCalculator();

  void startClock();
  void endClock();
  float getTime();

 private:
  cudaEvent_t _star;
  cudaEvent_t _stop;

  float _time;
};

