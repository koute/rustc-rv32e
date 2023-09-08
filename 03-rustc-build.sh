#!/bin/bash

set -euo pipefail

source config.sh

cd rust
./x build --target $TOOLCHAIN_HOST_TRIPLET --target riscv32em-unknown-none-elf
