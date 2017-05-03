#!/usr/bin/env bash -eux

echo "==> Updating system."
if [[ "$PACKER_OS_ID" =~ "Debian" ]] ; then
  apt-get -y update
  apt-get -y -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" dist-upgrade
elif [[ "$PACKER_OS_ID" =~ "CentOS" ]] ; then
  yum -y update
fi

echo "==> Rebooting system."
reboot
sleep 60
