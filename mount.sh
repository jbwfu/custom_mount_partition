#!/system/bin/sh

MODDIR=$(dirname $(realpath $0))

. "$MODDIR/function.sh"
init_conf "$MODDIR/conf"

mount_partition

start_mount_dir

chmod +x "$MODDIR/custom_mount.sh"
$MODDIR/custom_mount.sh
