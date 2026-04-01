# 运行阶段 - 最小化镜像
FROM node:25.8-alpine3.23
RUN apk add --no-cache bash ca-certificates libssl3
RUN npm install -g openclaw@latest @slack/web-api @slack/bolt @aws-sdk/client-bedrock
# 创建配置目录
RUN mkdir -p /root/.openclaw

EXPOSE 18789

# 设置默认命令
CMD ["openclaw onboard --install-daemon"]
