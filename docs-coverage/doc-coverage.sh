#!/bin/bash
set -eu

case $(uname) in
  Linux)
    pip install coverxygen
    cd build
    $GITHUB_ACTION_PATH/doc_coverage.py -b .
    ;;

  Darwin | Windows* | MINGW* | MSYS*)
    echo "This action is expected to run only in Linux"
    ;;

  *)
    echo "Unknown platform:" $(uname)
    exit 1
    ;;
esac
