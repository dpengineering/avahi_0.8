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
# Installation on Ubuntu

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

# Installation on RPi5 with Trixie

```
# Enter a terminal on the Pi

cd ~
sudo systemctl stop avahi-daemon.socket avahi-daemon.service avahi-daemon
sudo systemctl disable avahi-daemon.socket avahi-daemon.service avahi-daemon
sudo apt purge -y avahi-daemon
sudo find / -path “/home” -prune -o -name “*avahi*” -print 2>/dev/null
sudo find / -path “/home/pi” -prune -o -name “*avahi*” -exec rm -rf {} + 2>/dev/null
sudo apt purge avahi* -y
sudo cp /etc/apt/sources.list /etc/apt/sources.list~ # Only necessary if there are any sources previously in the file
sudo nano /etc/apt/sources.list
```
```
# Change the file to look similar to this (you may need to uncomment or add some lines yourself):

deb http://deb.debian.org/debian trixie main contrib non-free non-free-firmware
deb http://deb.debian.org/debian-security/ trixie-security main contrib non-free non-free-firmware
deb http://deb.debian.org/debian trixie-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian trixie main contrib non-free  non-free-firmware
deb-src http://deb.debian.org/debian-security/ trixie-security main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian trixie-updates main contrib non-free non-free-firmware
```
```
# Continue in the terminal:

sudo apt-get update
sudo apt-get build-dep -y avahi
sudo apt install -y libevent-dev qtbase5-dev mono-mcs mono-complete 
sudo apt-get update && sudo apt-get upgrade
cd /
sudo git clone https://github.com/dpengineering/avahi_0.8.git
cd avahi_0.8/
sudo ./bootstrap.sh # if monodoc gives you trouble when doing ./bootstrap.sh, add FLAGS="$FLAGS --disable-monodoc" underneath Linux) in bootstrap.sh
sudo make install
sudo /sbin/ldconfig -v	
sudo adduser --disabled-password --quiet --system --home /var/run/avahi-daemon -gecos “Avahi mDNS daemon” --group avahi
sudo nano /etc/dhcpcd.conf
```
```
# Change the file to look similar to this (these should be the only uncommented lines):

# Inform the DHCP server of our hostname for DDNS.
hostname

# Use the hardware address of the interface for the Client ID.
clientid

# Persist interface configuration when dhcpcd exits.
persistent

# vendorclassid is set to blank to avoid sending the default of
# dhcpcd-<version>:<os>:<machine>:<platform>
vendorclassid

# A list of options to request from the DHCP server.
option rapid_commit

option domain_name_servers, domain_name, domain_search
option classless_static_routes
# Respect the network MTU. This is applied to DHCP routes.
option interface_mtu

# Request a hostname from the network
option host_name

# A ServerID is required by RFC2131.
require dhcp_server_identifier

Generate Stable Private IPv6 Addresses based from the DUID
slaac private

# Configuration of eth0 with a static IP for remote management.
interface eth0
static ip_address=172.17.21.2/24
```
```
# Continue in the terminal:

sudo apt-get update && sudo apt-get -y upgrade
sudo systemctl daemon-reload
sudo systemctl restart avahi-daemon
reboot
```

To check that Avahi is working properly, you can use:
```
systemctl status avahi-daemon # This should show no errors
avahi-browse --all --resolve # You should be able to see local Pi's if it is working correctly
```
	
