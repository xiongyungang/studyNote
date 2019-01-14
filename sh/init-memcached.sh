PARTNER=${HOSTNAME##*-}
if [ "$PARTNER" = "0" ]; then
        PARTNER=$MY_POD_NAME-1
fi
if [ "$PARTNER" = "1" ]; then
        PARTNER=$MY_POD_NAME-0
fi

result=$(</dev/tcp/$PARTNER.$MY_POD_NAME.itfarm3.svc.cluster.local/$COPY_PORT && echo 200)
if [ "$result" = "200" ]; then
        # 复制master节点
        memcached -p 11211 -X $COPY_PORT -x $PARTNER.$MY_POD_NAME.itfarm3.svc.cluster.local -v -d -u root
else
        # 启动master节点
        memcached -p 11211 -X $COPY_PORT -v -d -u root
fi