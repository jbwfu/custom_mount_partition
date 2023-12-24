#!/system/bin/sh
#2023/07/05

MODDIR=$(dirname $(realpath $0))

. "$MODDIR/function.sh"
init_conf "$MODDIR/conf"

mount_partition

start_mount_home

# 其他自定义挂载
# homeRootDir="/mnt/runtime/full/emulated/0"
# mountParameters="-t sdcardfs -o rw,nosuid,nodev,noexec,noatime,fsuid=1023,fsgid=1023,gid=9997,derive_gid,default_normal"
# mount_home 需挂载绝对路径 挂载后绝对路径