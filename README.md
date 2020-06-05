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
url=github.com/kisslinux/repo/releases/download/1.10.0
wget "$url/kiss-chroot.tar.xz"
url=raw.githubusercontent.com/kisslinux/kiss/master/contrib
wget "$url/kiss-chroot"
chmod +x kiss-chroot
tar xvf kiss-chroot.tar.xz -C /mnt/gentoo --strip-components 1
mount /dev/sda1 /mnt/gentoo/boot
mkdir /mnt/gentoo/boot/efi
mount /dev/sda2 /mnt/gentoo/boot/efi
echo -e "/dev/sda1\t\t/boot\t\tvfat\t\tnoauto,noatime\t1 2" >> /mnt/gentoo/etc/fstab
echo -e "/dev/sda3\t\t/\t\text4\t\tnoatime\t\t0 1" >> /mnt/gentoo/etc/fstab
echo "mcpcpc" >> /mnt/gentoo/etc/hostname
./kiss-chroot /mnt/gentoo

cd && wget https://raw.githubusercontent.com/mcpcpc/kiss-sequoia-install/master/dirlist.tx
while read paths; do
    mkdir "$paths"
done < dirlist.txt
rm dirlist.txt

export CFLAGS="-O3 -pipe -march=native"
export CXXFLAGS="-O3 -pipe -march=native"
export MAKEFLAGS="-j8"
export KISS_PROMPT=0
kiss update
cd /var/db/kiss/installed && kiss build *
kiss b e2fsprogs && kiss i e2fsprogs
kiss b dosfstools && kiss i dosfstools
kiss b util-linux && kiss i util-linux
kiss b eudev && kiss i eudev
kiss b libelf && kiss i libelf
kiss b ncurses && kiss i ncurses
kiss b openssh && kiss i openssh
cd && git clone https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git
cp linux-firmware/iwlwifi-3168-2* /usr/lib/firmware/
cp linux-firmware/amdgpu/raven_* /usr/lib/firmware/amdgpu/
cp linux-firmware/amd/* /usr/lib/firmware/amd/
cd /usr/src
wget https://cdn.kernel.org/pub/linux/kernel/v5.x/linux-5.6.15.tar.xz
tar xvf linux-*
cd linux-*
wget https://raw.githubusercontent.com/mczigler/kiss-sequoia-install/master/.config
wget https://k1ss.org/dist/kernel-no-perl.patch
patch -p1 < no-perl.patch
make menuconfig
make -j8
make modules_install
make install
mv /boot/vmlinuz /boot/vmlinuz-5.6.15
mv /boot/System.map /boot/System.map-5.6.15
kiss b grub && kiss i grub
kiss b efibootmgr && kiss i efibootmgr
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=kiss
grub-mkconfig -o /boot/grub/grub.cfg
kiss b baseinit && kiss i baseinit
adduser mc
addgroup mc video
addgroup mc audio
kiss b dhcpcd && kiss i dhcpcd
kiss b wpa_supplicant && kiss i wpa_supplicant
cd /etc/wpa_supplicant && wget https://raw.githubusercontent.com/mczigler/kiss-sequoia-install/master/wpa_supplicant.conf
ln -s /etc/sv/udevd/ /var/service
ln -s /usr/share/dhcpcd/hooks/10-wpa_supplicant /usr/lib/dhcpcd/dhcpcd-hooks/
ln -s /etc/sv/dhcpcd/ /var/service
ln -s /etc/sv/sshd/ /var/service
```

```sh
# as root
wget https://raw.githubusercontent.com/mcpcpc/kiss-sequoia-install/master/bud && chmod +x bud && install bud /usr/bin/
wget https://raw.githubusercontent.com/dylanaraps/bin/master/x && chmod +x x && install x /usr/bin/
wget https://raw.githubusercontent.com/dylanaraps/bin/master/scr && chmod +x scr && install scr /usr/bin/
wget https://raw.githubusercontent.com/dylanaraps/bin/master/pfe && chmod +x pfe && install pfe /usr/bin/
```

```sh
# as regular user
cd && wget https://raw.githubusercontent.com/mcpcpc/kiss-sequoia-install/master/repolist.tx
while read repo; do
    git clone "$repo"
done < repolist.txt
rm repolist.txt
```

```sh
# as regular user
kiss b vim && kiss i vim
kiss b screen && kiss i screen
kiss b alsa-utils && kiss i alsa-utils
kiss b xorg-server && kiss i xorg-server
kiss b xf86-input-libinput && kiss i xf86-input-libinput
kiss b xauth && kiss i xauth
kiss b liberation-fonts && kiss i liberation-fonts
kiss b xf86-video-amdgpu && kiss i xf86-video-amdgpu
kiss b sx && kiss i sx
echo "XAuthLocation /usr/bin/xauth" >> /etc/ssh/sshd_config
echo "X11Forwarding yes" >> /etc/ssh/sshd_config
```

```sh
# as regular user
cd && wget https://raw.githubusercontent.com/mcpcpc/kiss-sequoia-install/master/dotslist.tx
while read dots; do
    wget "$dots"
done < dotslist.txt
rm dotslist.txt

mkdir ~/.ssh && cd ~/.ssh && wget https://raw.githubusercontent.com/mcpcpc/kiss-sequoia-install/master/.ssh/config
mkdir ~/.sx && mkdir ~/.sx/sx && cd ~/.sx/sx 
wget https://raw.githubusercontent.com/mcpcpc/kiss-sequoia-install/master/sxrc
```

```sh
# as regular user
kiss b imagemagick && kiss i imagemagick
kiss b ffmpeg && kiss i ffmpeg
kiss b firefox-bin && kiss i firefox-binv
kiss b dmenu && kiss i dmenu
kiss b st && kiss i st
kiss b sowm && kiss i sowm
```
