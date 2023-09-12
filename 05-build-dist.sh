#!/bin/bash

set -euo pipefail

source config.sh

cd rust
mkdir -p build/riscv32em-unknown-none-elf/compiler-doc
./x dist --target $TOOLCHAIN_HOST_TRIPLET --target riscv32em-unknown-none-elf
