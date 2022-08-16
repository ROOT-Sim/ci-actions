#!/bin/bash
# SPDX-FileCopyrightText: 2008-2021 HPDCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
set -eu

cmake -G "Unix Makefiles" -DCMAKE_C_COMPILER="$INPUT_CC" -DCMAKE_CXX_COMPILER="$INPUT_CXX" -DCMAKE_BUILD_TYPE="$INPUT_BUILD_TYPE" -DCMAKE_C_FLAGS="$INPUT_CFLAGS" -DCMAKE_CXX_FLAGS="$INPUT_CXXFLAGS" "$INPUT_SOURCE_DIR"
