FROM ubuntu-debootstrap:trusty
MAINTAINER alexandre.allouche@xcg-consulting.fr 

# Define some ENV variables
# this will be used as the default backend option for confd
ENV CONFD_BACKEND env

# generate a locale
RUN locale-gen en_US.UTF-8 && update-locale && echo 'LANG="en_US.UTF-8"' > /etc/default/locale

# add some system packages
RUN apt-get update && apt-get -y -q install \
	sudo less \
	net-tools \
	--no-install-recommends

# get latest stable etcdctl (client only)
# need to extract it from etcd package
ADD https://github.com/coreos/etcd/releases/download/v0.4.6/etcd-v0.4.6-linux-amd64.tar.gz /opt/sources/
RUN tar xzf /opt/sources/etcd-v0.4.6-linux-amd64.tar.gz -C /usr/local/bin etcd-v0.4.6-linux-amd64/etcdctl --strip-components=1 && \
	rm /opt/sources/etcd-v0.4.6-linux-amd64.tar.gz


# get latest stable confd
# ADD will always add downloaded files with a 600 permission
ADD https://github.com/kelseyhightower/confd/releases/download/v0.7.1/confd-0.7.1-linux-amd64 /usr/local/bin/confd
RUN chmod +x /usr/local/bin/confd
