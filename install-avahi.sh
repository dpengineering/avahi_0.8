#!/bin/bash

#Disable Avahi
systemctl stop avahi-daemon.socket avahi-daemon.service
apt purge -y avahi-daemon

#Switch apt-get method
cp /etc/apt/sources.list /etc/apt/sources.list~
sed -Ei 's/#deb-src /deb-src /' /etc/apt/sources.list
#For Ubuntu:
#sed -Ei 's/# deb-src /deb-src /' /etc/apt/sources.list
apt-get update

#Install Dependencies
apt-get build-dep -y avahi
apt install -y libevent-dev qtbase5-dev mono-mcs monodoc-http

#Build Avahi
./bootstrap.sh
make
make install

#Find Libraries
/sbin/ldconfig -v

#Add avahi user
adduser --disabled-password --quiet --system --home /var/run/avahi-daemon --gecos "Avahi mDNS daemon" --group avahi

#Start avahi
systemctl daemon-reload
systemctl start avahi-daemon
systemctl enable avahi-daemon

reboot

