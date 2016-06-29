FROM ubuntu:xenial
MAINTAINER alexandre.allouche@xcg-consulting.fr 

# Define some ENV variables
# this will be used as the default backend option for confd
ENV CONFD_BACKEND env

# generate a locale and ensure it on system users
RUN locale-gen en_US.UTF-8 && update-locale && echo 'LANG="en_US.UTF-8"' > /etc/default/locale
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

# add some system packages
RUN apt-get update && apt-get -y -q install \
	sudo less \
	net-tools \
	--no-install-recommends

# get latest stable etcdctl (client only)
# need to extract it from etcd package
ADD https://github.com/coreos/etcd/releases/download/v2.0.12/etcd-v2.0.12-linux-amd64.tar.gz /opt/sources/etcd.tar.gz
RUN tar xzf /opt/sources/etcd.tar.gz -C /usr/local/bin etcd-v2.0.12-linux-amd64/etcdctl --strip-components=1 && \
	rm /opt/sources/etcd.tar.gz


# get latest stable confd
# ADD will always add downloaded files with a 600 permission
ADD https://github.com/kelseyhightower/confd/releases/download/v0.10.0/confd-0.10.0-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd
