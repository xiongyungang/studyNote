#!/bin/bash
# 根据Dockerfile生成Image并上传至目标仓库

# todo:login
# dockerfile文件目录
DOCKERFILE_PATH=.
# 目标仓库地址
TARGET_REGISTORY=harbor.oneitfarm.com
# 域名空间
NAMESPACE=deployv2
# 工作目录
WORK=toolbox
docker build -f DOCKERFILE_PATH/Dockerfile.php56 -t "$TARGET_REGISTORY/$NAMESPACE/$WORK:php-5.6" .
docker push "$TARGET_REGISTORY/$NAMESPACE/$WORK:php-5.6"

docker build -f DOCKERFILE_PATH/Dockerfile.php71 -t "$TARGET_REGISTORY/$NAMESPACE/$WORK:php-7.1" .
docker push "$TARGET_REGISTORY/$NAMESPACE/$WORK:php-7.1"

docker build -f DOCKERFILE_PATH/Dockerfile.php72 -t "$TARGET_REGISTORY/$NAMESPACE/$WORK:php-7.2" .
docker push "$TARGET_REGISTORY/$NAMESPACE/$WORK:php-7.2"

docker build -f DOCKERFILE_PATH/Dockerfile.php70 -t "$TARGET_REGISTORY/$NAMESPACE/$WORK:php-7.0" .
docker push "$TARGET_REGISTORY/$NAMESPACE/$WORK:php-7.0"