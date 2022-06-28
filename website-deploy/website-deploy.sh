#!/bin/bash
# SPDX-FileCopyrightText: 2008-2021 HPDCS Group <rootsim@googlegroups.com>
# SPDX-License-Identifier: GPL-3.0-only
set -eu

if [ "$BRANCH_NAME" != "master" ] && [ "$BRANCH_NAME" != "develop" ]; then
  exit 0
fi

case $(uname) in
  Linux)
    [ ! -e "website/docs/$BRANCH_NAME" ] || rm -rf "website/docs/$BRANCH_NAME"
    mkdir -p "website/docs/"
    mv coverage.json "website/docs/$BRANCH_NAME.json"
    mv "build/$INPUT_BUILD_PATH/html" "website/docs/$BRANCH_NAME"
    mv README.md website
    cd website
    git add .
    git config --global user.email "rootsim@googlegroups.com"
    git config --global user.name "ROOT-Sim Bot"
    git commit --amend -m "Update Website"
    git push --force
    ;;

  Darwin | Windows* | MINGW* | MSYS*)
    echo "This action is expected to run only in Linux"
    ;;

  *)
    echo "Unknown platform: $(uname)"
    exit 1
    ;;
esac
