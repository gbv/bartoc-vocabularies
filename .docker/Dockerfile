FROM ubuntu:22.04
WORKDIR /usr/src/app

# ---------- Base tools ----------
RUN apt update && apt install -y \
  curl \
  wget \
  bash \
  git \
  make \
  jq \
  ca-certificates \
  && rm -rf /var/lib/apt/lists/*

# ---------- Node.js via NodeSource ----------
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash && \
    apt install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# ---------- Deno ----------
RUN apt update && apt install -y unzip && rm -rf /var/lib/apt/lists/* && \
    curl -fsSL https://deno.land/install.sh | sh && \
    ln -s /root/.deno/bin/deno /usr/bin/deno

# ---------- Copy script Docker-related ----------
COPY .docker/*.sh .
COPY .docker/*.ts .

# Cache Deno dependencies for update script
RUN deno cache --reload --lock=deno.lock update.ts 

# ---------- Git safe directory ----------
RUN git config --global --add safe.directory /bartoc-vocabularies

# ---------- Entrypoint ----------
CMD ["bash", "entrypoint.sh"]
