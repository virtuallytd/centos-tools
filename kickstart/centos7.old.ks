cmdline
install
lang en_GB.UTF-8
keyboard us
timezone Europe/Berlin
auth --useshadow --enablemd5
selinux --disabled
firewall --disabled
services --disabled=NetworkManager
services --enabled=sshd
eula --agreed
ignoredisk --only-use=sda
reboot

network --bootproto=dhcp --device=eth0 --onboot=off --ipv6=auto --no-activate
network --hostname=server.localdomain

# System bootloader configuration
bootloader --location=mbr --boot-drive=sda
zerombr
clearpart --all --initlabel
part pv.01 --size=1 --ondisk=sda --grow
part /boot --fstype="xfs" --ondisk=sda --size=1024
volgroup vg_system pv.01
logvol swap --fstype="swap" --size=2048 --name=swap --vgname=vg_system
logvol / --fstype="xfs" --name=lv_root --vgname=vg_system --size=1 --grow

# Password is Password123$
rootpw --iscrypted $1$v9a1rt9i$U65p6z39VFTN90WeBhC9u/

repo --name=base --baseurl=http://mirror.centos.org/centos/7/os/x86_64/
repo --name=updates --baseurl=http://mirror.centos.org/centos/7/updates/x86_64/
url --url="http://mirror.centos.org/centos/7/os/x86_64/"

%packages --nobase --ignoremissing --excludedocs
@core
-iwl*
-NetworkManager*
%end
