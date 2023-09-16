#!/usr/bin/env bash

set -euo pipefail

sudo mkdir -p /opt/clang-rv32e
sudo chown $USER /opt/clang-rv32e

cd rust/src/llvm-project
mkdir -p build
cd build
cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/clang-rv32e -DLLVM_ENABLE_PROJECTS=clang -DLLVM_TARGETS_TO_BUILD="X86;AArch64;RISCV;WebAssembly" -DLLVM_ENABLE_RUNTIMES=compiler-rt ../llvm
ninja
ninja install

cd ../compiler-rt
mkdir -p build
cd build

CFLAGS="--target=riscv32 -march=rv32em -mabi=ilp32e -nostdlib -nodefaultlibs"
cmake -G Ninja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/opt/clang-rv32e \
    -DCOMPILER_RT_BAREMETAL_BUILD=ON \
    -DCMAKE_AR=/opt/clang-rv32e/bin/llvm-ar \
    -DCMAKE_ASM_COMPILER_TARGET="riscv32" \
    -DCMAKE_ASM_FLAGS="$CFLAGS" \
    -DCMAKE_C_COMPILER=/opt/clang-rv32e/bin/clang \
    -DCMAKE_C_COMPILER_TARGET="riscv32" \
    -DCMAKE_C_FLAGS="$CFLAGS" \
    -DCMAKE_EXE_LINKER_FLAGS="-fuse-ld=lld" \
    -DCMAKE_NM=/opt/clang-rv32e/bin/llvm-nm \
    -DCMAKE_RANLIB=/opt/clang-rv32e/bin/llvm-ranlib \
    -DCOMPILER_RT_BUILD_BUILTINS=ON \
    -DCOMPILER_RT_BUILD_LIBFUZZER=OFF \
    -DCOMPILER_RT_BUILD_MEMPROF=OFF \
    -DCOMPILER_RT_BUILD_PROFILE=OFF \
    -DCOMPILER_RT_BUILD_SANITIZERS=OFF \
    -DCOMPILER_RT_BUILD_XRAY=OFF \
    -DCOMPILER_RT_DEFAULT_TARGET_ONLY=ON \
    -DLLVM_CONFIG_PATH=/opt/clang-rv32e/bin/llvm-config \
    ..
ninja
ninja install

echo ""
echo "Clang installed to '/opt/clang-rv32e'!"
echo "Binary available in: '/opt/clang-rv32e/bin/clang'"
