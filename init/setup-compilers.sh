#!/bin/bash
set -eu

case $(uname) in
    Linux)
        echo "No need to install anything"
       ;;

    Darwin)
        echo "No need to install anything"
        ;;

    Windows*)
        choco upgrade llvm -y --no-progress --allow-downgrade
        #choco upgrade mingw -y --no-progress --allow-downgrade
        ;;

    *)
        echo "Unknown platform:" $(uname)
        exit 1
        ;;
esac
