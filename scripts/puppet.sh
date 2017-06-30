#!/usr/bin/env bash -eux

if [ "$PACKER_INSTALL_PUPPET" == "false" ]; then
  echo "==> Skipping Puppet install"
else
  echo "==> Install Puppet Agent"
  if [[ "$PACKER_OS_ID" =~ "Debian" ]]; then
    /usr/bin/wget https://apt.puppetlabs.com/puppetlabs-release-pc1-${PACKER_OS_NAME}.deb
    /usr/bin/dpkg -i puppetlabs-release-pc1-${PACKER_OS_NAME}.deb
    /usr/bin/apt-get update
    /usr/bin/apt-get -y dist-upgrade
    /usr/bin/apt-get -y install puppet-agent
    rm puppetlabs-release-pc1-${PACKER_OS_NAME}.deb
  elif [[ "$PACKER_OS_ID" =~ "CentOS" ]]; then
    if [ "$PACKER_OS_NAME" = "centos6" ]; then
      /usr/bin/yum install -y https://yum.puppetlabs.com/puppetlabs-release-pc1-el-6.noarch.rpm
    elif [ "$PACKER_OS_NAME" = 'centos7' ]; then
      /usr/bin/yum install -y https://yum.puppetlabs.com/puppetlabs-release-pc1-el-7.noarch.rpm
    fi
    /usr/bin/yum update -y
    /usr/bin/yum install -y puppet-agent
  fi
  rm -fr /etc/puppetlabs/code/environments/*
fi
