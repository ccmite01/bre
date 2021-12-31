This docker image provides a Minecraft Bedrock Server that will automatically download the Microsoft selectable version at startup.
Japanese localization.

# To simply use the latest stable version, run
docker run -d -p 19132:19132 -v /host/directory/servers:/opt/minecraft -v /host/directory/admin:/var/www/html --name bre ccmite/bre


# Example Docker Compose app

* docker-compose.yml

<pre>
version: '2.2'
services:
# C.C.mite Server ###################################################
  bre:
    image: ccmite/bre:latest
    container_name: bre
    hostname: bre
    tty: true
    networks:
      - net
    volumes:
      - '/var/mcbe/servers:/opt/minecraft'
      - '/var/www/admin:/var/www/html/ccadmin'
    ports:
      - '19132:19132'
      - '19122:22'
      - '19143:8443'
    environment:
      MC_INSTANCE_NAME: ccmite
      MCBE_VERSION: 1.18.2
      MCBE_BUILD: 02
      LANG: ja-JP.UTF-8
    extra_hosts:
      - "ROUTER:192.168.0.1"
    mem_limit: 2g


# bridge ###################################################

networks:
  net:
    name: net
    driver: bridge

</pre>


# WebConsole

*  Forked from SuperPykkon/minecraft-server-web-console
<pre>
http://serverIP:8443/console/
username: admin
password: do_not_copy_and_paste
</pre>
