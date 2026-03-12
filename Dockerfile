FROM alpine:latest
ARG TARGETARCH
ARG TARGETVARIANT

# 添加程序
ADD vnt2_web_$TARGETARCH$TARGETVARIANT /app/vnt2_web

RUN apk update && \
    apk add iptables-legacy && \ 
    ln -sf /usr/sbin/iptables-legacy /usr/sbin/iptables && \
    ln -sf /usr/sbin/ip6tables-legacy /usr/sbin/ip6tables \
    ln -sf /app/vnt2_web /usr/sbin/vnt2_web
    
RUN apk add --no-cache tzdata && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apk del tzdata

# 设置工作目录
WORKDIR /app

# 设置中文环境变量和上海时区
ENV LANG=zh_CN.UTF-8 
ENV LANGUAGE=zh_CN:zh
ENV TZ=Asia/Shanghai

# 设置程序为可执行
RUN chmod +x /app/vnt2_web

# 挂载配置目录
VOLUME /app/vnt_config

# 终止信号
STOPSIGNAL SIGINT

# 设置 entrypoint
ENTRYPOINT ["./vnt2_web"]
