#!/usr/bin/env bash

set -euo pipefail

cd rust
mkdir -p build/riscv32em-unknown-none-elf/compiler-doc
python x.py dist
