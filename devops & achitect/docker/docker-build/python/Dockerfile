FROM python:3.12-slim AS builder

# Prevent Python from writing .pyc files and buffer stdout/err
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# ===== 环境变量：让 apt / uv / pip 都走代理 & 国内源 =====
ARG HTTP_PROXY
ARG HTTPS_PROXY
ARG http_proxy
ARG https_proxy
ARG UV_INDEX_URL       # uv 的国内源
ARG PIP_INDEX_URL      # pip 的国内源（备用）
ENV HTTP_PROXY=${HTTP_PROXY}
ENV HTTPS_PROXY=${HTTPS_PROXY}
ENV http_proxy=${http_proxy}
ENV https_proxy=${https_proxy}
ENV UV_INDEX_URL=${UV_INDEX_URL}
ENV PIP_INDEX_URL=${PIP_INDEX_URL}
RUN sed -i 's@deb.debian.org@mirrors.aliyun.com@g' /etc/apt/sources.list.d/debian.sources

# 安装编译依赖 (仅在构建阶段存在)
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*
    
COPY requirements.t requirements.t

# Explicitly install runtime dependencies (requirements.txt in the repo is binary, so we list them here)
RUN python -m pip install --no-cache-dir --upgrade pip setuptools wheel \
    && mkdir -p /wheels \
    && python -m pip wheel --no-cache-dir -r requirements.t -w /wheels

# 瘦身
FROM python:3.12-slim AS production
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1
WORKDIR /app
# 安装 wheel（不需要编译器）
COPY --from=builder /wheels /wheels
RUN python -m pip install --no-cache-dir /wheels/* \
    && rm -rf /wheels

# Copy application source
COPY . .

# Create default writable paths expected by the app
RUN mkdir -p /app/logs

# 与 CONFIG_FILE_PATH - SERVICE_PORT 保持一致
EXPOSE 8001

CMD ["python", "main.py"]
# CMD ["tail", "-f", "/dev/null"]
