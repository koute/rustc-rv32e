#!/bin/bash

export TOOLCHAIN_HOST_TRIPLET=$(rustc --version --verbose | grep 'host: ' | sed -r 's/host: (.*)/\1/')
export TOOLCHAIN_NAME=rv32e-nightly-2023-04-05
