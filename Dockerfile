# 运行阶段 - 最小化镜像
FROM ubuntu:22.04
RUN apk add --no-cache ca-certificates libssl3
RUN npm install -g openclaw@latest
# 创建配置目录
RUN mkdir -p /root/.openclaw

EXPOSE 18789

# 设置默认命令
CMD ["openclaw" ,"gateway" ,"run"]
