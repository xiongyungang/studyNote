#!/bin/bash
# 根据Dockerfile生成Image并上传至目标仓库

#login
#docker login registry.cn-shanghai.aliyuncs.com -u nanjingruyue -p ci123asdf
docker login ccr.ccs.tencentyun.com -u 100006908749 -p nibaguai1405

# dockerfile文件目录
DOCKERFILE_PATH=.
# 目标仓库地址
TARGET_REGISTORY=ccr.ccs.tencentyun.com
# 域名空间
NAMESPACE=itfarm
# 工作目录
WORK=cilnmp
docker build -f Dockerfile.php56 -t "$TARGET_REGISTORY/$NAMESPACE/$WORK:php-5.6" .
docker push "$TARGET_REGISTORY/$NAMESPACE/$WORK:php-5.6"

docker build -f Dockerfile.php71 -t "$TARGET_REGISTORY/$NAMESPACE/$WORK:php-7.1" .
docker push "$TARGET_REGISTORY/$NAMESPACE/$WORK:php-7.1"

docker build -f Dockerfile.php72 -t "$TARGET_REGISTORY/$NAMESPACE/$WORK:php-7.2" .
docker push "$TARGET_REGISTORY/$NAMESPACE/$WORK:php-7.2"

docker build -f Dockerfile.php70 -t "$TARGET_REGISTORY/$NAMESPACE/$WORK:php-7.0" .
docker push "$TARGET_REGISTORY/$NAMESPACE/$WORK:php-7.0"

read