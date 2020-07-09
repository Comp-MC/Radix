#!/usr/bin/env bash

pushd Radix-Server
git rebase --interactive upstream/upstream
popd
