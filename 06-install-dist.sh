#!/usr/bin/env bash

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

inst "rustc-nightly-x86_64-unknown-linux-gnu"
inst "rust-dev-nightly-x86_64-unknown-linux-gnu"
inst "rust-std-nightly-x86_64-unknown-linux-gnu"
inst "rust-std-nightly-riscv32em-unknown-none-elf"
inst "cargo-nightly-x86_64-unknown-linux-gnu"
inst "rust-src-nightly"
inst "rustfmt-nightly-x86_64-unknown-linux-gnu"
inst "clippy-nightly-x86_64-unknown-linux-gnu"
inst "rustc-docs-nightly-x86_64-unknown-linux-gnu"
inst "rustc-docs-nightly-riscv32em-unknown-none-elf"
