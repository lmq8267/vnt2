# VNT2

### Docker部署命令示例：

其中`/opt/vnt_config`对应你宿主机目录，用来固化保存配置文件，防止更新丢失配置，`192.168.1.1:19099`对应你宿主机的ip地址和vnt2的web监听端口,复制时注意修改为你实际的值

- CMD

```
docker run --name vnt2 --net=host --privileged --restart=always  -v /opt/vnt_config:/app/vnt_config -d lmq8267/vnt2 --addr 192.168.1.1:19099
```

- docker-compose.yaml

```
version: "3.8"

services:
  vnt2:
    image: lmq8267/vnt2
    container_name: vnt2
    network_mode: host
    privileged: true
    restart: always
    volumes:
      - /opt/vnt_config:/app/vnt_config
    command: ["--addr", "192.168.1.1:19099"]
```

### vnt2_web 参数

```
 --addr <ADDR>  本地http服务监听地址，默认仅监听127.0.0.1:19099
 --conf <CONF>  加载vnt配置路径，配置内容参考web端的配置格式
```
