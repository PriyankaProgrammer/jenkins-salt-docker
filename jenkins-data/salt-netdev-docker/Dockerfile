FROM debian:stretch

MAINTAINER ping@mirceaulinic.net

## Install min deps
RUN apt-get update \
  && apt-get install -y apt-utils \
  && apt-get install -y wget \
  && apt-get install -y gnupg \
  && apt-get install -y git \
  && rm -rf /var/lib/apt/lists/*

## Setup sources for Jessie backports and SaltStack repo
RUN echo 'deb http://httpredir.debian.org/debian stretch-backports main' >> /etc/apt/sources.list \
    && echo 'deb http://repo.saltstack.com/apt/debian/9/amd64/archive/2017.7.5/ stretch main' >> /etc/apt/sources.list.d/saltstack.list \
    && wget -O - https://repo.saltstack.com/apt/debian/9/amd64/archive/2017.7.5/SALTSTACK-GPG-KEY.pub | apt-key add - \
    && apt-get update -y \
    && apt-get upgrade -y \
    && apt-get install -y vim curl python-pip  

## Install backports
RUN apt-get install -y python-zmq \
    && apt-get install systemd -y

## Install the Salt Master Salt API 
RUN apt-get install -y salt-master salt-api

ADD master /etc/salt/master

#RUN mkdir -p /etc/pki/tls/certs/ 
#RUN openssl req -nodes -newkey rsa:1024 -keyout /etc/pki/tls/certs/localhost.key -out /etc/pki/tls/certs/localhost.crt -subj "/C=IN/ST=Maharashtra/L=Mumbai/O=Super Secure Company/OU=IT Department/CN=`hostname`"
RUN salt-call --local tls.create_self_signed_cert

# Add Run File
ADD run-master.sh /usr/local/bin/run.sh
RUN chmod +x /usr/local/bin/run.sh \
    && curl -O https://codeload.github.com/cherrypy/cherrypy/tar.gz/3.2.3 \
    && tar -xvzf 3.2.3 \
    && cd cherrypy-3.2.3/ \
    && python setup.py install \
    && service salt-master restart \
    && service salt-api restart \
    && cd \  
    && useradd jenkins \
    && echo "jenkins:jenkins" | /usr/sbin/chpasswd 

# Ports
EXPOSE 4505 4506 8080

# Run Command
CMD "/usr/local/bin/run.sh"
