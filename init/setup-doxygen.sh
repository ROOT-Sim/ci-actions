#!/bin/bash
set -eu

case $(uname) in
  Linux)
   sudo apt-get update
   sudo DEBIAN_FRONTEND=noninteractive apt-get install -yq --no-install-recommends doxygen graphviz
   ;;

  Darwin)
    brew install doxygen
    brew install graphviz
    ;;

  Windows* | MINGW* | MSYS*)
    choco install doxygen.install --installargs 'ADD_CMAKE_TO_PATH=System'
    choco install graphviz --installargs 'ADD_CMAKE_TO_PATH=System'
    ;;

  *)
    echo "Unknown platform:" $(uname)
    exit 1
    ;;
esac
