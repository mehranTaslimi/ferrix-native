#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/.."

declare -a FLAGS=()
PROFILE=debug

if [[ "${CONFIGURATION:-Debug}" == "Release" ]]; then
  FLAGS+=(--release)
  PROFILE=release
fi

cargo build -p ferrix-uniffi ${FLAGS[@]+"${FLAGS[@]}"}

LIB="target/$PROFILE/libferrix_uniffi.dylib"

mkdir -p bindings/swift
cargo run -p ferrix-uniffi ${FLAGS[@]+"${FLAGS[@]}"} --bin uniffi-bindgen -- \
  generate --library "$LIB" --language swift --out-dir bindings/swift

echo "✅ bindings generated"
