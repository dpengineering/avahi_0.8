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

FRESHMEAT:
	http://freshmeat.net/projects/avahi/

OHLOH:
	http://www.ohloh.net/projects/avahi/

AUTHORS:
	Lennart Poettering
	Trent Lloyd

-----------------------------------------------------------------
# Installation

```
# Reboot into recovery mode by rebooting and pressing the Esc key once the BIOS are done running and select "Advanced options for Ubuntu" then choose an option ending with "(Recovery Mode)" (usually the second option).
# From there, chose the "Drop to root shell" prompt. Enter the root password, and you should be good to start re-installing avahi.

sudo systemctl stop avahi-daemon.service 
sudo systemctl stop avahi-daemon.socket
sudo apt purge avahi-daemon
rm -r avahi
rm -r avahi_0.8 #use one of the two, depending on what is currently existing
git clone https://github.com/dpengineering/avahi_0.8.git
cd avahi_0.8
sudo apt install build-essential
sudo apt install libexpat1*
sudo ./bootstrap.sh
sudo make install
sudo apt install avahi-daemon # When prompted, use own config (most likely option "N")
echo "avahi-daemon hold" | sudo dpkg --set-selections # Paul recomends making sure that any future updates to avahi-daemon do not overide this custom implementation (Basically - Put the package on hold)
reboot
```

To check that Avahi is working properly, you can use:
```
systemctl status avahi-daemon # This should show no errors
avahi-browse --all --resolve # You should be able to see local Pi's if it is working correctly
```
	
