#!/usr/bin/env bash -eux

if [[ "$PACKER_OS_ID" =~ "CentOS" ]] ; then
  echo "==> Adding EPEL Repository."
  case "$PACKER_OS_NAME" in
    centos7)
      EPEL_RPM_URL=https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
      ;;
    centos6)
      EPEL_RPM_URL=https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm
      ;;
  esac
  yum -y install ${EPEL_RPM_URL}
  echo "==> Installing prerequites."
  yum -y install gcc kernel-devel kernel-headers dkms make bzip2 perl
elif [[ "$PACKER_OS_ID" =~ "Debian" ]] ; then
  echo "==> Installing prerequites."
  apt-get -y install build-essential module-assistant linux-headers-amd64
fi

echo "==> Installing Guest Additions."
mkdir /tmp/virtualbox
VERSION=$(cat /home/vagrant/.vbox_version)
mount -o loop /home/vagrant/VBoxGuestAdditions_${VERSION}.iso /tmp/virtualbox
sh /tmp/virtualbox/VBoxLinuxAdditions.run --nox11
umount /tmp/virtualbox
rmdir /tmp/virtualbox
rm /home/vagrant/VBoxGuestAdditions_${VERSION}.iso
rm /home/vagrant/.vbox_version
