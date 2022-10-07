AVAHI SERVICE DISCOVERY SUITE

Avahi is a free, LGPL implementation of DNS Service Discovery (DNS-SD RFC 6763) over Multicast DNS (mDNS RFC 6762),
commonly known as and compatible with Apple Bonjour primarily targetting Linux.

Copyright 2004-2015 by the Avahi developers.

WEB SITE:
	http://avahi.org/

GIT:
	http://github.com/lathiat/avahi.git

MAILING LIST:
	http://lists.freedesktop.org/mailman/listinfo/avahi

IRC:
	#avahi on irc.freenode.org

CIA:
	http://cia.navi.cx/stats/project/avahi

FRESHMEAT:
	http://freshmeat.net/projects/avahi/

OHLOH:
	http://www.ohloh.net/projects/avahi/

AUTHORS:
	Lennart Poettering
	Trent Lloyd

## Installation 

Disable avahi:

`sudo systemctl stop avahi-daemon.socket avahi-daemon.service`

`sudo systemctl disable avahi-daemon.socket avahi-daemon.service`

`sudo apt purge avahi-daemon`

Install Dependencies:

`sudo apt install build-essential manpages-dev libevent-dev qtbase5-dev mono-mcs monodoc-http net-tools`

`sudo apt-get build-dep avahi`


*If apt-get build-dep avahi throws an error:*

`sudo cp /etc/apt/sources.list /etc/apt/sources.list~`

`sudo sed -Ei s/^# deb-src /deb-src / /etc/apt/sources.list`

`sudo apt-get update`

Compile:

`./autogen.sh && sudo make && sudo make install`

Enable avahi:

`sudo systemctl enable avahi-daemon.socket avahi-daemon.service`

`sudo systemctl start avahi-daemon.socket avahi-daemon.service`

Add user avahi:

`sudo adduser --disabled-password --quiet --system         --home /var/run/avahi-daemon         --gecos "Avahi mDNS daemon" --group avahi`

Add the dbus conf file:

`sudo cp avahi-dbus.conf /etc/dbus-1/system.d/avahi-dbus.conf`