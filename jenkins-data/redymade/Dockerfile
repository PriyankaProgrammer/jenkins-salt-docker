FROM centos:6
MAINTAINER umm.no@nothere.com
RUN rpm -Uvh http://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
RUN yum install -y wget  monit 
RUN wget -O /tmp/install_salt.sh https://bootstrap.saltstack.com
RUN sh /tmp/install_salt.sh -D -X
RUN [ ! -d /etc/salt/minion.d ] && mkdir /etc/salt/minion.d
RUN echo "master: 192.168.10.48" >> /etc/salt/minion
ADD files/monit /etc/monit.d/monit
CMD ["/usr/bin/monit", "-I"]
