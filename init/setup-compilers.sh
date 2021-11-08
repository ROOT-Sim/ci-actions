#!/bin/bash
set -eu

case $(uname) in
    Linux)
        echo "No need to install anything"
       ;;

    Darwin)
        echo "No need to install anything"
        ;;

    Windows* | MINGW*)
        choco install --yes llvm
        ;;

    *)
        echo "Unknown platform:" $(uname)
        exit 1
        ;;
esac
