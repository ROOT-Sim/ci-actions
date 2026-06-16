#!/bin/bash
# SPDX-FileCopyrightText: 2008-2025 HPCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
set -eu

eval "args=($INPUT_CMAKE_ARGS)"
cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$INPUT_CC" -DCMAKE_CXX_COMPILER="$INPUT_CXX" -DCMAKE_BUILD_TYPE="$INPUT_BUILD_TYPE" -DCMAKE_C_FLAGS="$INPUT_CFLAGS" -DCMAKE_CXX_FLAGS="$INPUT_CXXFLAGS" ${args[@]:+"${args[@]}"} "$INPUT_SOURCE_DIR"
