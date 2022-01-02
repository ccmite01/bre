#!/bin/bash
if [ ! -d /opt/minecraft/${MC_INSTANCE_NAME} ]
            then
                        mkdir -p /opt/minecraft/${MC_INSTANCE_NAME}
                            chown www-data:www-data /opt/minecraft/${MC_INSTANCE_NAME}
fi

if [ ! -d /var/www/html/console ]
            then
                        tar -x -v -f /console.tar.gz -C /var/www/html/
                            chmod +x /var/www/html/console/*.sh
                                sed -i "s/ccmite/${MC_INSTANCE_NAME}/g" /var/www/html/console/config/config.php
fi

cd /opt/minecraft/${MC_INSTANCE_NAME}
if [ ! -e bedrock_server ]
          then
                     curl -s -k --tlsv1.2 https://minecraft.azureedge.net/bin-linux/bedrock-server-${MCBE_VERSION}.${MCBE_BUILD}.zip -o bedrock-server.zip
                           unzip -q bedrock-server.zip
                           chown -R www-data:www-data *
fi
screen -S apc /usr/sbin/apachectl start
mkdir -p /opt/minecraft/ssh
touch /opt/minecraft/ssh/authorized_keys
chown root:root /opt/minecraft/ssh/authorized_keys
chmod 600 /opt/minecraft/ssh/authorized_keys
/etc/init.d/ssh start
screen -S mcs su -s /bin/bash - www-data -c "export TZ=JST-9; export LANG=ja_JP.UTF-8; cd /opt/minecraft/${MC_INSTANCE_NAME}; export LD_LIBRARY_PATH=.; ./bedrock_server"
