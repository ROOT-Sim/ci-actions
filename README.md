# ROOT-Sim Actions

[![CI](https://github.com/ROOT-Sim/ci-actions/actions/workflows/build-test.yml/badge.svg)](https://github.com/ROOT-Sim/ci-actions/actions/workflows/build-test.yml)

This is the set of actions that are used across the different ROOT-Sim repositories to support
CI/CD of the components of the project.

Currently, the actions supported are:
* Ensure that proper compilers are available (clang, gcc) on the three major platforms (Ubuntu, macOS, Windows)
* Install MPI (openmp on Ubuntu, mpich on macOS, Microsoft MPI on Windows)
* Compile and test a CMake project
* Generate the documentation of the project
* Compute the documentation coverage

## License

This project is released under the [GPLv3](LICENSES/GPL-3.0-only.txt).

## Usage

This is a short walk-through, used mostly for internal reference.


### Build & Test

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
        uses: actions/checkout@v4
      - name: Initialize Environment
        uses: ROOT-Sim/ci-actions/init@v1.6
      - name: Build & Test
        uses: ROOT-Sim/ci-actions/cmake@v1.6
        with:
          build-dir: ${{ runner.workspace }}/build
          cc: ${{ matrix.compiler }}
          build-type: ${{ matrix.type }}
          run-test: true
```

Note that the `init` action, by default, installs all the dependencies that are used by the ROOT-Sim
core project, both for building and for documentation purposes. Among them, there are the MPI library
and Doxygen. These dependencies take time to be configured, especially on Windows and Linux. If some
project does not need them, they can be phased out from the initialization. This can be done as
follows:

```yaml
    - name: Initialize Environment
      uses: ROOT-Sim/ci-actions/init@v1.6
      with:
        with-mpi: no
        with-doxygen: no
```


### Documentation

In order to generate the documentation of the project, the following step can be included to generate the Doxygen
documentation:

```yaml
    - name: Generate Documentation
      uses: ROOT-Sim/ci-actions/docs@v1.6
```

Note that in the above case, it is automatically triggering the build of a `doc` target from `CMakeLists.txt`.
If the target to generate Doxygen documentation is different, it can be specified with the `docs-target` parameter:

```yaml
    - name: Generate Documentation
      uses: ROOT-Sim/ci-actions/docs@v1.6
      with:
        docs-target: generate-documentation
```

If you want to perform a documentation coverage, the following step can be included. It *must* come after the `docs`
action. If running in a pull request, it will comment the pull request with information on the coverage.

```yaml
    - name: Documentation Coverage
      uses: ROOT-Sim/ci-actions/docs-coverage@v1.6
      with:
        accept-threshold: "60.0"
        build-path: build/docs
```

The previous action creates and environment message in the variable `COMMENT`. You can make an automatic comment in
a pull request using the following step, after its execution:

```yaml
    - name: Comment PR
      uses: actions/github-script@v3
      with:
        github-token: ${{secrets.GITHUB_TOKEN}}
        script: |
          github.issues.createComment({
            issue_number: context.issue.number,
            owner: context.repo.owner,
            repo: context.repo.repo,
            body: ${{env.COMMENT}}
          })
```

Also, an env `acceptable` variable with the value 0 or 1 is set, to determine whether the test has passed or not.


### REUSE compliance

If you want to perform a REUSE check (which fails the CI if the check does not pass), you can use the following:

```yaml
    - name: REUSE check
      uses: ROOT-Sim/ci-actions/reuse-check@v1.6
```


### Copyright Update

We also have an action to update the copyright headers in the source files. This is useful to keep the
copyright information up to date across the project.

Currently, the action will look for the following pattern: `2008-[0-9]{4} HPCS Group` and update the second
year to the current year. We do not offer the possibility to specify the pattern, yet.

It can be used in a cron job, as follows (runs at 1 am on January 1st of every year):

```yaml
name: update-copyright

on:
  schedule:
    - cron: "0 1 1 1 *"

jobs:
  update-copyright:
    runs-on: ubuntu-latest
    steps:
    - name: Update copyright
      uses: ROOT-Sim/ci-actions/update-copyright@v1.6
      with:
        branch-to-update: develop
```
