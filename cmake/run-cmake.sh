#!/bin/bash
set -eu

case $(uname) in
    Linux)
       mkdir build
       cd build
       cmake ..
       ;;

    Darwin)
        echo "TODO"
        exit 1
        ;;

    Windows*)
        echo "TODO"
        exit 1
        ;;

    *)
        echo "Unknown platform:" $(uname)
        exit 1
        ;;
esac
