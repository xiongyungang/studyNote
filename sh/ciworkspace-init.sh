#!/bin/bash

set -xe

## configure ssh
rm -f /etc/service/sshd/down
echo -e 'y\n'|ssh-keygen -P "" -t rsa -f /etc/ssh/ssh_host_rsa_key
echo -e 'y\n'|ssh-keygen -P "" -t dsa -f /etc/ssh/ssh_host_dsa_key

if [ -n "$GIT_PRIVATE_KEY" ]; then
    key_file_path="/root/.ssh/id_rsa"
    config_file_path="/root/.ssh/config"
    echo $GIT_PRIVATE_KEY | base64 -d > $key_file_path
    echo "Host gitlab.oneitfarm.com 
    HostName gitlab.oneitfarm.com
    Port 29622" > $config_file_path
    ssh-keyscan -p 29622 gitlab.oneitfarm.com 2>/dev/null > /root/.ssh/known_hosts
    chmod 600 $key_file_path $config_file_path
fi

if [ -n "$SSH_PUBLIC_KEY" ]; then
    echo $SSH_PUBLIC_KEY | base64 -d > /root/.ssh/authorized_keys
    chmod 600 /root/.ssh/authorized_keys
fi


cp $PHP_FPM_WWW_CONF /tmp/www.conf

envsubst '$$PHP_MAX_CHILDREN$$PHP_START_SERVERS$$PHP_MIN_SPARE_SERVERS$$PHP_MAX_SPARE_SERVERS' < /tmp/www.conf > $PHP_FPM_WWW_CONF

if [ "$ENVIRONMENT" == "develop" ]; then
    echo "display_errors = On" >> $PHP_CUSTOM_INI
    echo "display_startup_errors = On"; >> $PHP_CUSTOM_INI
    sed -i 's@^;php_flag[display_errors].*@php_flag[display_errors] = On@' $PHP_FPM_WWW_CONF
else
    echo "display_errors = Off" >> $PHP_CUSTOM_INI
    echo "display_startup_errors = Off"; >> $PHP_CUSTOM_INI
    sed -i 's@^;php_flag[display_errors].*@php_flag[display_errors] = Off@' $PHP_FPM_WWW_CONF
fi
