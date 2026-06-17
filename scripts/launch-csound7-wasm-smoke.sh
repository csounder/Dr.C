#!/usr/bin/env bash
# Csound 7 WASM smoke test — local HTTP server + browser
set -euo pipefail

WASM_DIR="${CSOUND7_WASM_DIR:-${HOME}/Dr.C-WASM}"
PORT="${CSOUND7_WASM_PORT:-8791}"

[[ -d "$WASM_DIR" ]] || {
  echo "Csound 7 WASM folder not found: $WASM_DIR"
  read -r -p "Press Enter to close..." || true
  exit 1
}

cd "$WASM_DIR"

if ! lsof -i ":${PORT}" >/dev/null 2>&1; then
  echo "Starting HTTP server on http://127.0.0.1:${PORT}/"
  python3 -m http.server "$PORT" --bind 127.0.0.1 >/tmp/Dr.C-WASM-server.log 2>&1 &
  sleep 1
fi

open "http://127.0.0.1:${PORT}/smoke-test.html"
