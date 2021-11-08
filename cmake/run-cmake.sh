#!/bin/bash
set -eu

case $(uname) in
  Linux)
    mkdir build
    cd build
    cmake ..
    ;;

  Darwin)
    mkdir build
    cd build
    cmake ..
    ;;

  Windows* | MINGW*)
    echo "TODO"
    exit 1
    ;;

  *)
    echo "Unknown platform:" $(uname)
    exit 1
    ;;
esac
