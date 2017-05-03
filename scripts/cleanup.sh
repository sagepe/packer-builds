#!/usr/bin/env bash -eux

# Package cleanup.
if [[ "$PACKER_OS_ID" =~ "Debian" ]] ; then
  apt-get -y autoremove --purge
  apt-get -y clean
elif [[ "$PACKER_OS_ID" =~ "CentOS" ]] ; then
  yum clean all
fi

## Networking
for rules in \
  "/etc/udev/rules.d/70-persistent-net.rules" \
  "/lib/udev/rules.d/75-persistent-net-generator.rules" ;
do
  if [ -e "${rules}" ] ; then rm -f ${rules} ; fi
done

if [ -d "/dev/.udev/" ]; then rm -fr /dev/.udev/ ; fi

if [[ "$PACKER_OS_ID" =~ "CentOS" ]] ; then
  sed -i /HWADDR/d /etc/sysconfig/network-scripts/ifcfg-eth0
  sed -i /UUID/d /etc/sysconfig/network-scripts/ifcfg-eth0
fi

if [[ "$PACKER_OS_ID" =~ "Debian" ]] ; then
  echo "pre-up sleep 2" >> /etc/network/interfaces
fi

## DHCP
rm -fr /var/lib/dhcp/*

## Shell history
unset HISTFILE
rm -f /root/.bash_history
rm -f /home/vagrant/.bash_history

## Log files
find /var/log -type f | while read log ; do :> $log ; done

## tmp
rm -fr /tmp/*

## Disk space
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
sync
