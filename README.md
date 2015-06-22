ubuntu trusty with confd and etcd dockerized
============================================

This is based on ubuntu-debootstrap:trusty with built-in etcdctl and confd as executable binaries

What is it?
===========

Nothing more than the genuine ubuntu:trusty with binaries from the last stable releases of

    confd https://github.com/coreos/etcd/releases
    etcdctl https://github.com/kelseyhightower/confd/releases 

!!!Latest changes!!!
====================
UPDATED etcdctl to 2.0. Make sure to upgrade your etcd registry following [this guide][1].

UPDATED confd to 0.10.

ADDED a workaround to ensure a locale is defined for any user inside the container.

Usage
=====
include this as a base image when you intend to use confd or connect to an existing etcd service

  [1] https://github.com/coreos/etcd/blob/master/tools/etcd-migrate/README.md
