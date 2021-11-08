cmake_minimum_required(VERSION 3.10)
project(ci-actions-test LANGUAGES C)

find_package(MPI REQUIRED)
add_compile_options(${TARGET_NAME} ${MPI_C_COMPILE_FLAGS})
include_directories(SYSTEM ${MPI_C_INCLUDE_PATH})
link_libraries(${MPI_C_LIBRARIES})

add_executable(test_program test.c)
enable_testing()
add_test(test_program test_program)
