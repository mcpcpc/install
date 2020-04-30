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
mkfs.ext4 /dev/sda1
mkfs.ext4 /dev/sda3
mkfs.vfat -F 32 /dev/sda2
mount /dev/sda3 /mnt/gentoo
url=github.com/kisslinux/repo/releases/download/1.9.11
wget "$url/kiss-chroot.tar.xz"
url=raw.githubusercontent.com/kisslinux/kiss/master/contrib |
wget "$url/kiss-chroot"
chmod +x kiss-chroot
tar xvf kiss-chroot.tar.xz -C /mnt --strip-components 1
./kiss-chroot /mnt/gentoo
```
