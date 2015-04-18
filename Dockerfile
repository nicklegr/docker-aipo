FROM centos:centos6

RUN yum install -y tar sudo
RUN sed -i -e "s/^Defaults    requiretty/#Defaults    requiretty/" /etc/sudoers
RUN yum install -y wget gcc nmap lsof unzip readline-devel zlib-devel

WORKDIR /tmp
RUN wget -q http://jaist.dl.sourceforge.jp/aipo/63098/aipo-8.0-linux-x64.tar.gz
RUN tar xzf aipo-8.0-linux-x64.tar.gz

WORKDIR /tmp/aipo-8.0-linux-x64
RUN sh installer.sh

RUN rm /tmp/aipo-8.0-linux-x64.tar.gz
RUN rm -r /tmp/aipo-8.0-linux-x64
RUN yum clean all

WORKDIR /usr/local/aipo/bin/
ENTRYPOINT ./startup.sh && tail -f /dev/null
