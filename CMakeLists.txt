# Specify the minimum version of cmake
cmake_minimum_required(VERSION 3.26)

# Project Information
project(cmake-cuda-demo)

# Add languages needed when building the project
enable_language(CXX)
enable_language(CUDA)

# Set the C++ version
set(CMAKE_CXX_STANDARD 11)

# Set CUDA architecture type (optional)
#set(CMAKE_CUDA_ARCHITECTURES 70)

# Add include folder path to INCLUDE_DIR and src folder path to SRC_DIR
set(INCLUDE_DIR "${CMAKE_SOURCE_DIR}/include")
set(SRC_DIR "${CMAKE_SOURCE_DIR}/src")

# All files in src folder are stored in SRC_FILES variable
file(GLOB SRC_FILES "${SRC_DIR}/*.cpp" "${SRC_DIR}/*.c" "${SRC_DIR}/*.cu")

# Output file list information (optional)
message(STATUS "Src files: ${SRC_FILES}")

# Add generate target
add_executable(${PROJECT_NAME} ${SRC_FILES})

# find CUDA package
find_package(CUDAToolkit  REQUIRED)
find_package(OpenMP REQUIRED)

#REQUIRED: 如果指定的包找不到，CMake 将报错并停止进一步的配置过程。这是确保项目依赖性的关键参数。
#QUIET: 当设置为 QUIET 时，即使找不到包，CMake 也不会在控制台输出任何警告或错误信息。这通常用于可选依赖项。
#MODULE: 这个参数告诉 CMake 查找的是 CMake 模块文件（.cmake 文件），而不是包配置文件

# Add CUDA header directory (locally)
target_include_directories(${PROJECT_NAME} PRIVATE ${CUDA_INCLUDE_DIRS})
target_include_directories(${PROJECT_NAME} PRIVATE ${INCLUDE_DIR})

#PRIVATE：链接的库仅对目标自身可见。
#PUBLIC：链接的库对目标自身和链接到该目标的所有其他目标都可见。
#INTERFACE：链接的库仅对链接到该目标的其他目标可见。

# Add CUDA header directory (globally)
#include_directories(${CUDA_INCLUDE_DIRS})

# Linked CUDA library
target_link_libraries(${PROJECT_NAME} PRIVATE ${CUDA_CUDART_LIBRARY})

# Linked Thrust library
#target_link_libraries(${PROJECT_NAME} PRIVATE ${Thrust_LIBRARIES})

# Linked cublas library
#target_link_libraries(${PROJECT_NAME} PRIVATE ${CUDA_cublas_LIBRARY})

# Linked curand library
#target_link_libraries(${PROJECT_NAME} PRIVATE ${CUDA_curand_LIBRARY})

# Linked openMP library
target_link_libraries(${PROJECT_NAME} PRIVATE OpenMP::OpenMP_CXX)
