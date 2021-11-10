#!/bin/bash
set -eu

case $(uname) in
  Linux)
    mkdir build
    cd build
    cmake -DDOXYGEN_INPUT_FILTER=$GITHUB_ACTION_PATH/doxygen_spdx_filter.py -DDOXYGEN_GENERATE_XML=YES ..
    cmake --build . --target doc
    find .
    ;;

  Darwin | Windows* | MINGW* | MSYS*)
    echo "This action is expected to run only in Linux"
    ;;

  *)
    echo "Unknown platform:" $(uname)
    exit 1
    ;;
esac
