#!/bin/bash
set -eu

case $(uname) in
  Linux | Darwin | Windows* | MINGW* | MSYS*)
    mkdir build
    cd build
    cmake -DDOXYGEN_INPUT_FILTER=$GITHUB_ACTION_PATH/doxygen_spdx_filter.py ..
    cmake --build . --target doc
    ;;

  *)
    echo "Unknown platform:" $(uname)
    exit 1
    ;;
esac
