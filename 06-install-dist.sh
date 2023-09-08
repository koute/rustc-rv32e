#!/bin/bash

set -euo pipefail

source config.sh

inst () {
    echo "Installing: $1"
    mkdir -p unpack/$1
    cd unpack/$1
    tar -xf ../../rust/build/dist/$1.tar.xz
    cd $1
    ./install.sh --disable-ldconfig --prefix=/ --destdir="~/.rustup/toolchains/$TOOLCHAIN_NAME"
    cd ../../..
}

inst "rustc-nightly-$TOOLCHAIN_HOST_TRIPLET"
inst "rust-dev-nightly-$TOOLCHAIN_HOST_TRIPLET"
inst "rust-std-nightly-$TOOLCHAIN_HOST_TRIPLET"
inst "rust-std-nightly-riscv32em-unknown-none-elf"
inst "cargo-nightly-$TOOLCHAIN_HOST_TRIPLET"
inst "rust-src-nightly"
inst "rustfmt-nightly-$TOOLCHAIN_HOST_TRIPLET"
inst "clippy-nightly-$TOOLCHAIN_HOST_TRIPLET"
inst "rustc-docs-nightly-$TOOLCHAIN_HOST_TRIPLET"
inst "rustc-docs-nightly-riscv32em-unknown-none-elf"
