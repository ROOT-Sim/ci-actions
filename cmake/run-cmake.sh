#!/bin/bash
set -eu

case $(uname) in
  Linux | Darwin | Windows* | MINGW* | MSYS*)
    echo "Source dir: ${{ inputs.source-dir }}"
    echo "Build dir: ${{ inputs.build-dir }}"
    echo "Build type: ${{ inputs.build-type }}"
    echo "CC: ${{ inputs.cc }}"
    echo "CXX: ${{ inputs.cxx }}"
    echo "target: ${{ inputs.target }}"
    echo "Run tests: ${{ inputs.run-test }}"

#    mkdir build
#    cd build
#    cmake ..
    ;;

#-DCMAKE_BUILD_TYPE=
#-DCMAKE_CXX_FLAGS=
#-DCMAKE_C_FLAGS=

  *)
    echo "Unknown platform:" $(uname)
    exit 1
    ;;
esac
