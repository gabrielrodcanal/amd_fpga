#!/bin/bash

MLIR_INPUT=$1
LL_OUTPUT=$2
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source $SCRIPT_DIR/config.sh
shopt -s expand_aliases

soda-opt $MLIR_INPUT --lower-affine --canonicalize --lower-all-to-llvm=use-bare-ptr-memref-call-conv | \
soda-mlir-translate --mlir-to-llvmir --opaque-pointers=0 -o $LL_OUTPUT
