#!/usr/bin/env bash
set -euo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$REPO_ROOT"

export CARGO_TARGET_DIR="${CARGO_TARGET_DIR:-$REPO_ROOT/target}"

PROFILE_DIR="debug"
CARGO_PROFILE_FLAGS=()
if [[ "${CONFIGURATION:-Release}" == "Release" ]]; then
  PROFILE_DIR="release"
  CARGO_PROFILE_FLAGS+=(--release)
fi

echo "Building ferrix-uniffi (${PROFILE_DIR})..."
cargo build -p ferrix-uniffi "${CARGO_PROFILE_FLAGS[@]}"

LIB="$CARGO_TARGET_DIR/$PROFILE_DIR/libferrix_uniffi.dylib"

echo "Generating Swift bindings from: $LIB"
mkdir -p bindings/swift
cargo run -p ferrix-uniffi "${CARGO_PROFILE_FLAGS[@]}" --bin uniffi-bindgen -- \
  generate \
  --library "$LIB" \
  --language swift \
  --out-dir bindings/swift

echo "Done: bindings/swift"