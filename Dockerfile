# ------------------------------------------------------------
# AUTHOR:      Ole Weidner <ole.weidner@codewerft.net>
# DESCRIPTION: A MySQL 5.6 container. 
#
# TO_BUILD:    docker build --rm -t="codewerft/mysql" .
# TO_RUN:      docker run --name=mydb -d codewerft/mysql -v  /opt/containerdata/mysql:/var/lib/mysql -e MYSQL_ROOT_PASSWORD=mysecretpassword
# 
# Other useful flags: --restart=always

FROM ubuntu:14.04
MAINTAINER Ole Weidner <ole.weidner@codewerft.com>

# Update base distribution
# ------------------------------------------------------------

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update -y

# Install MySQL 5.5
# ------------------------------------------------------------
RUN apt-get update \
 && apt-get install -y mysql-server \
 && rm -rf /var/lib/mysql/mysql \
 && rm -rf /var/lib/apt/lists/* # 20140918

ADD start /start
RUN chmod 755 /start

CMD ["/start"]

#ADD my.cnf /etc/mysql/conf.d/my.cnf 
#ADD mysqld_charset.cnf /etc/mysql/conf.d/mysqld_charset.cnf

#COPY entrypoint.sh /entrypoint.sh
#RUN chmod +x /entrypoint.sh
#ENTRYPOINT ["/entrypoint.sh"]

# Install supervisor
# ------------------------------------------------------------

#RUN apt-get install -y supervisor
#RUN mkdir -p /var/log/supervisor
#RUN rm -r /etc/supervisor/conf.d/
#ADD supervisord.conf /etc/supervisor/supervisord.conf

# Exposed volumes
# ------------------------------------------------------------

VOLUME ["/run/mysqld"]
VOLUME ["/var/lib/mysql"]

# Exposed ports
# ------------------------------------------------------------

EXPOSE 3306

# Startup
# ------------------------------------------------------------

CMD ["/start"]
