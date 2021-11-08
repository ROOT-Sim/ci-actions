# ROOT-Sim Actions

[![ci](https://github.com/ROOT-Sim/ci-actions/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/ROOT-Sim/ci-actions/actions/workflows/ci.yml)

This is the set of actions that are used across the different ROOT-Sim repositories to support
CI/CD of the components of the project.

Currently, the actions supported are:
* Ensure that proper compilers are available (clang, gcc) on the three major platforms (Ubuntu, macOS, Windows)
* Install MPI (openmp on Ubuntu, mpich on macOS, Microsoft MPI on Windows)
* Compile and test a CMake project

## License

This project is released under the [GPLv3](LICENSE).

## Usage

This is a short walk-through, used mostly for internal reference.

To run CI of C/C++ projects, testing on all operating systems with a combination of the compilers and
libraries considered for the project, do the following:

```yaml
on:
  push:
  pull_request:
  schedule:
    - cron: "0 2 * * 1"

build_and_test:
    runs-on: ${{ matrix.os }}
    strategy:
      fail-fast: false
      matrix:
        os: [ ubuntu-latest, windows-latest, macos-latest ]
        compiler: [ clang, gcc ]
        type: [ Debug, Release ]
    steps:
      - name: Checkpout repository
        uses: actions/checkout@v2
      - name: Initialize Environment
        uses: ROOT-Sim/ci-actions/init@v1
      - name: Build & Test
        uses: ROOT-Sim/ci-actions/cmake@v1
        with:
          build-dir: ${{ runner.workspace }}/build
          cc: ${{ matrix.compiler }}
          build-type: ${{ matrix.type }}
          run-test: true
```
