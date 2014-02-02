#!/bin/bash

# example nas:/mnt/biggins/music
nfs_mount=${NFS_MOUNT}
mountpoint="/home/mopidy/music"
data_dir="/home/mopidy/data"

if [ ! $nfs_mount ]; then
  echo ""
  echo "***************************************"
  echo "must set NFS_MOUNT environment variable"
  echo "***************************************"
  echo ""

  echo "EXAMPLE:"
  echo "docker run -privileged -e NFS_MOUNT=nas:/mnt/biggins/music -p 6680:6680 -t narf/mopidy"
  echo ""
  exit 1
fi

rpcbind &&
rpc.statd &&

#mount -t nfs -o timeo=600 -o tcp -o hard -o bg $nfs_mount $mountpoint -vvvv &&
mount -t nfs $nfs_mount $mountpoint -vvv &&

df -h &&

mopidy --config /home/mopidy/mopidy.conf -vvv -o local/media_dir=$mountpoint -o local/data_dir=/$datadir local scan &&

mopidy --config /home/mopidy/mopidy.conf -vvv -o local/media_dir=$mountpoint -o local/data_dir=/$datadir
