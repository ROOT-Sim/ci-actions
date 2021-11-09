#!/bin/bash
set -eu

case $(uname) in
  Linux)
   sudo apt-get update
   sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends doxygen
   ;;

  Darwin)
    brew install doxygen
    ;;

  Windows* | MINGW* | MSYS*)
    choco install doxygen --installargs 'ADD_CMAKE_TO_PATH=System'
    ;;

  *)
    echo "Unknown platform:" $(uname)
    exit 1
    ;;
esac
