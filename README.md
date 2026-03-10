# Docker Project Template

A general-purpose development container template based on NVIDIA CUDA + Python (uv) + Node.js (For AI Service).

## Directory Structure

```
.
 Dockerfile                  # Image definition
 docker-compose.yml          # Container service configuration
 .env.example                # Environment variable template (copy to .env and fill in)
 .gitignore                  # Git ignore rules
 makefile                    # Common Docker commands
 .devcontainer/
    └── devcontainer.json       # VS Code Dev Container configuration
```

## Quick Start

1. **Copy `.env.example` to `.env`** and fill in your personal settings:
   ```bash
   cp .env.example .env
   ```

2. **Build the image**:
   ```bash
   make build
   ```

3. **Start the container**:
   ```bash
   make up
   ```

4. **Open a shell inside the container**:
   ```bash
   make terminal
   ```

## Available Commands

| Command          | Description                              |
| ---------------- | ---------------------------------------- |
| `make build`     | Build the Docker image                   |
| `make up`        | Start the container in the background    |
| `make down`      | Stop the container                       |
| `make terminal`  | Open a bash shell inside the container   |
| `make logs`      | Follow container logs                    |
| `make format`    | Format code with ruff                    |
| `make lint`      | Lint and auto-fix with ruff              |
| `make lock`      | Update uv.lock                           |
| `make clean`     | Remove all Docker resources              |

## Customisation Tips

- **Rename the project**: Set `PROJECT_NAME=your-project` in `.env`. This controls the Docker Compose project name and the built image tag. Also update `name` in `pyproject.toml` to keep it consistent.
- **Change the base image**: Edit the `FROM` line in `Dockerfile`, e.g. switch to CPU-only `python:3.12-slim`.
- **Mount a dataset**: Uncomment and edit the dataset volume in `docker-compose.yml`.
- **Add apt packages**: Extend the `apt-get install` block in `Dockerfile`.
- **Change Python version**: Edit the `UV_PYTHON` environment variable in `Dockerfile`.

---

# Docker 專案範本

基於 NVIDIA CUDA + Python (uv) + Node.js 的通用開發容器範本。

## 目錄結構

```
.
 Dockerfile                  # 映像檔定義
 docker-compose.yml          # 容器服務設定
 .env.example                # 環境變數範本（複製為 .env 後填入個人設定）
 .gitignore                  # Git 忽略規則
 makefile                    # 常用 Docker 指令
 .devcontainer/
    └── devcontainer.json       # VS Code Dev Container 設定
```

## 快速開始

1. **將 `.env.example` 複製為 `.env`**，並填入個人設定：
   ```bash
   cp .env.example .env
   ```

2. **建置映像檔**：
   ```bash
   make build
   ```

3. **啟動容器**：
   ```bash
   make up
   ```

4. **進入容器終端機**：
   ```bash
   make terminal
   ```

## 可用指令

| 指令             | 說明                             |
| ---------------- | -------------------------------- |
| `make build`     | 建置 Docker 映像檔               |
| `make up`        | 在背景啟動容器                   |
| `make down`      | 停止容器                         |
| `make terminal`  | 在容器內開啟 bash 終端機         |
| `make logs`      | 持續追蹤容器日誌                 |
| `make format`    | 使用 ruff 格式化程式碼           |
| `make lint`      | 使用 ruff 檢查並自動修正程式碼   |
| `make lock`      | 更新 uv.lock                     |
| `make clean`     | 移除所有 Docker 資源             |

## 客製化提示

- **重新命名專案**：在 `.env` 中設定 `PROJECT_NAME=your-project`，這會同時控制 Docker Compose 的專案名稱與建置後的映像檔標籤。另外也需手動更新 `pyproject.toml` 中的 `name` 欄位以保持一致。
- **更換基礎映像檔**：編輯 `Dockerfile` 中的 `FROM` 行，例如改為僅使用 CPU 的 `python:3.12-slim`。
- **掛載資料集**：取消 `docker-compose.yml` 中資料集 volume 的註解並修改路徑。
- **新增 apt 套件**：在 `Dockerfile` 的 `apt-get install` 區塊中追加套件。
- **變更 Python 版本**：編輯 `Dockerfile` 中的 `UV_PYTHON` 環境變數。
