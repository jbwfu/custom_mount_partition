#!/system/bin/sh

MODDIR=$(dirname $(realpath $0))

. "$MODDIR/function.sh"
init_conf "$MODDIR/conf"

mount_partition 2>&1 | tee mount.log

start_mount_dir 2>&1 | tee -a mount.log

chmod +x "$MODDIR/custom_mount.sh"
$MODDIR/custom_mount.sh 2>&1 | tee -a mount.log
