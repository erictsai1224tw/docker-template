# ==========================================
# Image — personal settings are passed in via .env
# Copy .env.example to .env and fill in your values
# ==========================================
FROM nvidia/cuda:12.4.1-devel-ubuntu22.04

COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

ENV PYTHONUNBUFFERED=1 \
    DEBIAN_FRONTEND=noninteractive \
    UV_COMPILE_BYTECODE=1 \
    UV_LINK_MODE=copy \
    UV_PYTHON=3.12 \
    VIRTUAL_ENV=/app/.venv \
    PATH="/app/.venv/bin:$PATH" \
    HF_HOME=/cache/huggingface \
    PYTHONPATH=/app:$PYTHONPATH

RUN apt-get update && apt-get install -y \
    software-properties-common \
    git \
    curl \
    build-essential \
    cmake \
    ninja-build \
    vim \
    ca-certificates \
    pkg-config \
    libcairo2-dev \
    libgirepository1.0-dev \
    libglib2.0-dev \
    libglib2.0-0 \
    libgl1-mesa-glx \
    libsm6 \
    libxext6 \
    libxrender-dev \
    libgomp1 \
    && curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -g 1000 docker && \
    useradd -u 1000 -g 1000 -m -s /bin/bash docker && \
    mkdir -p /cache/huggingface /app && \
    chown -R docker:docker /cache /app

WORKDIR /app
USER docker

# --- Project dependencies ---
# pyproject.toml is always present (template provided).
# uv.lock is optional:
#   - First build (no uv.lock): uv resolves dependencies and creates the lock file.
#   - Subsequent builds: copy uv.lock into the project root before building;
#     then switch to `uv sync --frozen --no-cache` for reproducible installs.
# Workflow: `make build` → `make lock` → add uv.lock to git → `make build` again.
COPY pyproject.toml ./
RUN uv venv $VIRTUAL_ENV && uv sync --no-cache
# ----------------------------

RUN mkdir -p /home/docker/.npm-global && \
    npm config set prefix '/home/docker/.npm-global'

ENV PATH="/home/docker/.npm-global/bin:$PATH"

RUN npm install -g @anthropic-ai/claude-code @google/gemini-cli @github/copilot

RUN mkdir -p /home/docker/.ssh && \
    chmod 700 /home/docker/.ssh && \
    git config --global --add safe.directory /app

# To mount SSH keys, uncomment the following:
# COPY --chown=docker:docker .ssh/id_rsa /home/docker/.ssh/id_rsa
# COPY --chown=docker:docker .ssh/id_rsa.pub /home/docker/.ssh/id_rsa.pub
# RUN chmod 600 /home/docker/.ssh/id_rsa && \
#     ssh-keyscan github.com >> /home/docker/.ssh/known_hosts

CMD ["sleep", "infinity"]
