#include "host.hpp"

#include <iostream>

void matrixAddHost(){
#pragma omp parallel for
    for (int i = 0; i < 100; ++i) {
        std::cout << i << std::endl;
    }
}

