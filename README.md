# ROOT-Sim Actions

[![ci](https://github.com/ROOT-Sim/ci-actions/actions/workflows/ci.yml/badge.svg?branch=master)](https://github.com/ROOT-Sim/ci-actions/actions/workflows/ci.yml)

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
        uses: actions/checkout@v3
      - name: Initialize Environment
        uses: ROOT-Sim/ci-actions/init@v1.2
      - name: Build & Test
        uses: ROOT-Sim/ci-actions/cmake@v1.2
        with:
          build-dir: ${{ runner.workspace }}/build
          cc: ${{ matrix.compiler }}
          build-type: ${{ matrix.type }}
          run-test: true
```

In order to generate the documentation of the project, the following step can be included, which requires that a target
named `doc` is present in `CMakeLists.txt` to generate the Doxygen documentation:

```yaml
    - name: Generate Documentation
      uses: ROOT-Sim/ci-actions/docs@v1.2
```

If you want to perform a documentation coverage, the following step can be included. It *must* come after the `docs`
action. If running in a pull request, it will comment the pull request with information on the coverage.

```yaml
    - name: Documentation Coverage
      uses: ROOT-Sim/ci-actions/docs-coverage@v1.2
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

If you want to perform a REUSE check (which fails the CI if the check does not pass), you can use the following:

```yaml
    - name: REUSE check
      uses: ROOT-Sim/ci-actions/reuse-check@v1.2
```

Another available action allows to deploy the documentation into a GitHub Pages website in the current repository.
This action can be used as such:

```yaml
    - name: Website Deployment
      uses: ROOT-Sim/ci-actions/website-deploy@v1.2
```

The documentation will be deployed in the `/docs/[branchname]/` path, where `[branchname]` is either `master` or 
`develop`. The documentation is not actually deployed for any other branch.
Additionally, it will copy the `README.md` file in the root directory of the website: if it is used in the site, the
content of the page will therefore be automatically updated.
