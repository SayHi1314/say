# 运行阶段 - 最小化镜像
FROM ubuntu:22.04
RUN apt update && apt install -y --no-install-recommends ca-certificates libssl3 curl wget git
# 安装 Node.js 24
RUN curl -fsSL https://deb.nodesource.com/setup_24.x | bash - && \
    apt-get install -y --no-install-recommends nodejs 
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt install -y ./google-chrome-stable_current_amd64.deb
RUN rm -rf google-chrome-stable_current_amd64.deb
RUN npm install -g openclaw@latest @slack/web-api grammy @slack/bolt @aws-sdk/client-bedrock @buape/carbon @larksuiteoapi/node-sdk
RUN openclaw doctor --fix
RUN rm -rf /var/lib/apt/lists/*
# 创建配置目录
RUN mkdir -p /root/.openclaw

EXPOSE 18789

# 设置默认命令
CMD ["sh", "-c", "openclaw gateway run || sleep 300"]
