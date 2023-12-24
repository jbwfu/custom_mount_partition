#!/system/bin/sh

MODDIR=$(dirname $(realpath $0))

. "$MODDIR/function.sh"
init_conf "$MODDIR/conf"

umount_dir

# umount_partition

# 其他自定义挂载
# umount 挂载后绝对路径
