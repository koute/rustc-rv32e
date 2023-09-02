## Rust toolchain for RV32E

This repository contains scripts to build a Rust toolchain targetting RISC-V RV32E.

The target triplet is: riscv32em-unknown-none-elf

**Warning**: This was only tested on Linux! Patches welcome if it doesn't work on your OS.

Note: This might require up to ~35GB of disk space to build.

## Building rustc

1. Run `./01-clone.sh`. This will download the necessary sources.
2. Run `./02-patch.sh`. This will patch the sources for RV32E.
3. Run `./03-rustc-build.sh`. This will build the compiler.

Now you have two options:

a) Link the toolchain you've built with `rustup` using the `04a-link-rustup.sh` script.
b) Build (potentially redistributable) dist artifacts with `05-build-dist.sh` and install them with `06-install-dist.sh`.

In case of (a) you'll have to keep this repository in-place as `rustup` will link to this directory
to access the toolchain. In case of (b) the toolchain will be permanently installed, after which
you can delete this repository.

## Using rustc

After installing prefix your `cargo` invocations with `rustup run rv32e-nightly-2023-04-05-x86_64-unknown-linux-gnu`
and add `--target=riscv32em-unknown-none-elf`. For example this should work:

```
rustup run rv32e-nightly-2023-04-05-x86_64-unknown-linux-gnu cargo build --target=riscv32em-unknown-none-elf
```

Only `no_std` is supported!

## Building clang (optional)

You can also build clang if you want. After cloning and patching the sources run `03-clang-build-and-install.sh`
to build and install it. The clang binary will be installed to `/opt/clang-rv32e/bin/clang`.

## License

MIT or Apache-2
