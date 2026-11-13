#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="/bartoc-vocabularies"
REPO_URL="https://github.com/gbv/bartoc-vocabularies"
BARTOC_BRANCH="${BARTOC_BRANCH:-main}"

# Clone the repository if it doesn't exist
if [ ! -e "${REPO_DIR}/.git" ]; then
  echo "Cloning branch ${BARTOC_BRANCH} from ${REPO_URL} into ${REPO_DIR}..."
  git clone --depth 1 --branch "${BARTOC_BRANCH}" "${REPO_URL}" "${REPO_DIR}"
else
  cd "${REPO_DIR}"
  echo "Using branch ${BARTOC_BRANCH} in ${REPO_DIR}..."
  git fetch --quiet origin "${BARTOC_BRANCH}"
  git switch --quiet "${BARTOC_BRANCH}" 2>/dev/null ||
    git switch --quiet --create "${BARTOC_BRANCH}" FETCH_HEAD
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
