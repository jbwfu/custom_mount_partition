#!/system/bin/sh

MODDIR=$(dirname $(realpath $0))

. "$MODDIR/function.sh"
init_conf "$MODDIR/conf"

chmod +x "$MODDIR/custom_umount.sh"
$MODDIR/custom_umount.sh

umount_dir

umount_partition
