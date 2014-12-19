# ------------------------------------------------------------
# AUTHOR:      Ole Weidner <ole.weidner@codewerft.net>
# DESCRIPTION: A MySQL 5.6 container. 
#
# TO_BUILD:    docker build --rm --no-cache -t="codewerft/mysql" .
# TO_RUN:      docker run -p 127.0.0.1:5000:80 --name=mydb -d codewerft/mysql
# 
# Other useful flags: --restart=always

FROM ubuntu:14.04
MAINTAINER Ole Weidner <ole.weidner@codewerft.com>

# Update base distribution
# ------------------------------------------------------------

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y
RUN apt-get upgrade -y

# Install MySQL 5.6
# ------------------------------------------------------------

RUN rm -rf /var/lib/mysql/*
RUN apt-get install -yq mysql-server-5.6 pwgen
ADD my.cnf /etc/mysql/conf.d/my.cnf 
ADD mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf

# Install supervisor
# ------------------------------------------------------------

RUN apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
RUN rm -r /etc/supervisor/conf.d/
ADD supervisord.conf /etc/supervisor/supervisord.conf

# Exposed volumes
# ------------------------------------------------------------

VOLUME  ["/var/lib/mysql"]

# Exposed ports
# ------------------------------------------------------------

EXPOSE 3306

# Startup
# ------------------------------------------------------------

CMD ["/usr/bin/supervisord"]
