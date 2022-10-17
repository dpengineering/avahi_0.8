#install dependencies
apt install -y gettext intltool libtool libglib2.0-dev libgdbm-dev libdaemon-dev libdbus-1-dev manpages-dev libevent-dev qtbase5-dev mono-mcs monodoc-http xmltoman

#change apt to get from bullseye
cp /etc/apt/sources.list /etc/apt/sources.list~
sed -Ei 's/^#deb-src /deb-src /' /etc/apt/sources.list
apt-get update

#install more dependencies
apt-get build-dep avahi

#Run bootstrap.sh to change build flags. bootstrap.sh also runs autogen.sh
./bootstrap.sh

#install avahi
make install

#Add avahi user
adduser --disabled-password --quiet --system --home /var/run/avahi-daemon --gecos "Avahi mDNS daemon" --group avahi

#Add avahi-dbus.conf to dbus
cp avahi-dbus.conf /etc/dbus-1/system.d/avahi-dbus.conf

#Start avahi
systemctl daemon-reload
systemctl start avahi-daemon
systemctl enable avahi-daemon

reboot
