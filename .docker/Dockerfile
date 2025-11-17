# .docker/Dockerfile (in bartoc-vocabularies)
FROM node:22-bookworm-slim

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
       bash \
       curl \
       jq \
       make \
       ca-certificates \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install Node deps (jskos-cli etc.)
COPY package.json package-lock.json ./
RUN npm ci --omit=dev

# Copy the rest (Makefile, import.sh, vocab dirs…)
COPY . .

# Default: interactive shell (useful locally; overridden in CI / on server)
CMD ["bash"]
