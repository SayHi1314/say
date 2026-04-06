# 运行阶段 - 最小化镜像
FROM ubuntu:22.04
RUN apt update && apt install -y --no-install-recommends ca-certificates libssl3 wget
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN apt install ./google-chrome-stable_current_amd64.deb
RUN rm -rf google-chrome-stable_current_amd64.deb
RUN npm install -g openclaw@latest
# 创建配置目录
RUN mkdir -p /root/.openclaw

EXPOSE 18789

# 设置默认命令
CMD ["openclaw" ,"gateway" ,"run"]
