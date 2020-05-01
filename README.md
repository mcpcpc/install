```sh
root@localhost ~ # gdisk /dev/sda
Create GPT partition table:
Command: o ↵
This option deletes all partitions and creates a new protective MBR.
Proceed? (Y/N): y ↵

Create Partition 1 (/boot):
Command: n ↵
Partition Number: ↵ (for 1)
First sector: ↵
Last sector: +128M ↵
Hex Code: ↵

Create Partition 2 (UEFI ESP):
Command: n ↵
Partition Number: ↵ (for 2)
First sector: ↵
Last sector: +33M ↵
Hex Code: EF00 ↵

Create Partition 3 (/):
Command: n ↵
Partition Number: ↵ (for 3)
First sector: ↵
Last sector: ↵ (for rest of disk)
Hex Code: ↵

Write Partition Table To Disk:
Command: w ↵
Do you want to proceed? (Y/N): Y ↵
```

```sh
tmux
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda3
mkfs.vfat -F 32 /dev/sda2
mount /dev/sda3 /mnt/gentoo
url1=github.com/kisslinux/repo/releases/download/1.9.11
url2=raw.githubusercontent.com/kisslinux/kiss/master/contrib
wget "$url1/kiss-chroot.tar.xz"
wget "$url2/kiss-chroot"
chmod +x kiss-chroot
tar xvf kiss-chroot.tar.xz -C /mnt/gentoo --strip-components 1
mount /dev/sda1 /mnt/gentoo/boot
mkdir /mnt/gentoo/boot/efi
mount /dev/sda2 /mnt/gentoo/boot/efi
echo -e "/dev/sda1\t\t/boot\t\tvfat\t\tnoauto,noatime\t1 2" >> /mnt/gentoo/etc/fstab
echo -e "/dev/sda3\t\t/\t\text4\t\tnoatime\t\t0 1" >> /mnt/gentoo/etc/fstab
./kiss-chroot /mnt/gentoo
export CFLAGS="-O3 -pipe -march=native"
export CXXFLAGS="-O3 -pipe -march=native"
export MAKEFLAGS="-j8"
kiss update
cd /ver/db/kiss/installed && kiss build *
kiss b e2fsprogs
kiss i e2fsprogs
kiss b dosfstools
kiss i dosfstools
kiss b util-linux
kiss i util-linux
kiss b eudev
kiss i eudev
kiss b dhcpcd
kiss i dhcpcd
kiss b wpa_supplicant
kiss i wpa_supplicant
mkdir /etc/wpa_supplicant
cd /etc/wpa_supplicant
url3=https://raw.githubusercontent.com/mczigler/kiss-sequoia-install/master
wget "$url3/wpa_supplicant.conf"
kiss b libelf
kiss i libelf
kiss b ncurses
kiss i ncurses
kiss b perl
kiss i perl
mkdir /usr/lib/firmware
cd /usr/lib/firmware
wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/iwlwifi-3168-22.ucode
wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/iwlwifi-3168-27.ucode
wget https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/iwlwifi-3168-29.ucode
cd /usr/src
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.6.8.tar.xz
tar xvf linux-*
cd linux-*
wget "$url3/.config"
make -j8
make modules_install
make install
mv /boot/vmlinuz /boot/vmlinuz-5.6.8
mv /boot/System.map /boot/System.map-5.6.8
kiss b grub
kiss i grub
kiss b efibootmgr
kiss i efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=kiss
grub-mkconfig -o /boot/grub/grub.cfg
kiss b baseinit
kiss i baseinit
adduser mc
kiss b xorg-server xinit xf86-input-libinput
kiss i xorg-server xinit xf86-input-libinput
kiss b liberation-fonts
kiss i liberation-fonts
addgroup mc video
addgroup mc audio
kiss b git
kiss i git
kiss b vim
kiss i vim
#kiss b opendoas
#kiss i opendoas
#echo 'permit nopass keepenv :wheel' > /etc/doas.conf
kiss b openssh
kiss i openssh
kiss b alsa-utils
kiss i alsa-utils
ln -s /etc/sv/udevd/ /var/service
ln -s /usr/share/dhcpcd/hooks/10-wpa_supplicant /usr/libexec/dhcpcd-hooks/
ln -s /etc/sv/dhcpcd/ /var/service
ln -s /etc/sv/sshd/ /var/service
```
