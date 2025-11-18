#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="/bartoc-vocabularies"
REPO_URL="https://github.com/gbv/bartoc-vocabularies"

# Clone the repository if it doesn't exist
if [ ! -e "${REPO_DIR}/.git" ]; then
  echo "Cloning ${REPO_URL} into ${REPO_DIR}..."
  git clone --depth 1 "${REPO_URL}" "${REPO_DIR}"
fi

cd "${REPO_DIR}"

# Install dependencies only if node_modules is missing
if [ -f package-lock.json ] && [ ! -d node_modules ]; then
  echo "Installing Node.js dependencies with npm ci..."
  npm ci
fi

# Folders per log
mkdir -p .log

echo "Node.js $(node --version)"
echo "npm $(npm --version)"
deno --version
