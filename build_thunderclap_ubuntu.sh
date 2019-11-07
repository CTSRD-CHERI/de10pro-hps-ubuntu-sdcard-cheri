#!/bin/bash

FPGA=$1

source /local/ecad/setup.bash 19.2pro

function umount_multiple
{
	DIR=$1
	while umount $DIR ; do
		echo "Unmounted $DIR"
	done
	true
}

# try to clean up errant loopback mounts
umount_multiple mnt/1
umount_multiple mnt/2
sync
losetup -D
sync

# remove old images
rm -f sdimage.img sdimage.img.xz
rm -rf mnt

# copy in the thunderclap binary to the image
mkdir -p payload/root
#mv build-arm/thunderclap payload/root/thunderclap

# build the SD card and compress it
#if [ "$FPGA" = "enclustra-mercury-aa1-pe1" ] ; then
	./scripts/build_ubuntu_sdcard.sh  boards/enclustra-mercury-aa1-pe1 refdes system payload libpixman-1-0 && \
	pxz sdimage.img
#else
#	./scripts/build_ubuntu_sdcard.sh  boards/intel-a10soc-devkit ghrd_10as066n2 ghrd_10as066n2 payload libpixman-1-0 && \
#	pxz sdimage.img
#
#fi

# make sure everything is unmounted
umount_multiple mnt/1
umount_multiple mnt/2
