# 编译阶段
FROM debian:bookworm-slim as builder

RUN apt-get update && apt-get install -y \
    curl \
    git \
    build-essential \
    pkg-config \
    libssl-dev \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# 安装 Rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /build

# 克隆 loongclaw 仓库
RUN git clone --branch dev https://github.com/loongclaw-ai/loongclaw.git .

# 构建 release 版本
RUN cargo build --release --bin loongclaw-daemon

# 运行阶段 - 最小化镜像
FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y \
    ca-certificates \
    libssl3 \
    && rm -rf /var/lib/apt/lists/*

# 从编译阶段复制二进制文件
COPY --from=builder /build/target/release/loongclaw-daemon /usr/local/bin/loongclaw-daemon

# 创建配置目录
RUN mkdir -p /root/.loongclaw

EXPOSE 8080

# 设置默认命令
CMD ["loongclaw-daemon"]
