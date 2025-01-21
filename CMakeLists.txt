# SPDX-FileCopyrightText: 2008-2021 HPDCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
cmake_minimum_required(VERSION 3.22.2)
project(ci-actions-test LANGUAGES C CXX)

find_package(MPI REQUIRED)
add_compile_options(${TARGET_NAME} ${MPI_CXX_COMPILE_FLAGS})
include_directories(SYSTEM ${MPI_CXX_INCLUDE_PATH})
link_libraries(${MPI_CXX_LIBRARIES})

add_executable(test_program test.c)
add_executable(test_program_cpp test.cpp)

enable_testing()
add_test(test_program test_program)
add_test(test_program_cpp test_program_cpp)

find_package(Doxygen)
doxygen_add_docs(doc-for-test ".")
