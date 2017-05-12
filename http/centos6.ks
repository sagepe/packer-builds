install
url --url=http://mirror.bytemark.co.uk/centos/6/os/x86_64/
lang en_GB.UTF-8
keyboard uk
network --bootproto=dhcp --noipv6
rootpw --iscrypted $6$1rqNrdv0$bq/SrCd1jUhX3GgOdwLxsrjb5wySU.yInWUXVq1v4bl1sZsWHjkFftKQWfkGVcQP/c/Wx6OuMoMcwRAWLaiT81
firewall --disabled
authconfig --enableshadow --passalgo=sha512
selinux --disabled
timezone Europe/London
bootloader --location=mbr

text
skipx
zerombr

clearpart --all --initlabel
autopart

auth  --useshadow  --enablemd5
firstboot --disabled
reboot

%packages
@core
openssh-clients
openssh-server
sudo
%end

%post
# Setup sudo
sed -i "s/^.*requiretty/#Defaults requiretty/" /etc/sudoers

# Vagrant User
/usr/sbin/groupadd vagrant
/usr/sbin/useradd vagrant -u 490 -g vagrant -G vagrant
echo "vagrant"|passwd --stdin vagrant
#echo "vagrant        ALL=(ALL)       NOPASSWD: ALL" >> /etc/sudoers.d/vagrant
#chmod 0440 /etc/sudoers.d/vagrant

# Speed up SSH
echo "UseDNS no" >> /etc/ssh/sshd_config

%end
