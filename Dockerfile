# 编译阶段
FROM rust:alpine3.23 AS builder

WORKDIR /src
RUN apk add --no-cache git
# 克隆 loongclaw 仓库
RUN git clone --branch dev https://github.com/loongclaw-ai/loongclaw.git .

# 构建 release 版本
RUN cargo install --path crates/daemon

# 运行阶段 - 最小化镜像
FROM alpine:3.21

# 从编译阶段复制二进制文件
COPY --from=builder /usr/local/bin/loong /usr/local/bin/loong

# 创建配置目录
RUN mkdir -p /root/.loongclaw

EXPOSE 8080

# 设置默认命令
CMD ["loong"]
