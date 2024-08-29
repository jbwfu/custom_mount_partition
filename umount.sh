#!/system/bin/sh

MODDIR=$(dirname $(realpath $0))

. "$MODDIR/function.sh"
init_conf "$MODDIR/conf"

chmod +x "$MODDIR/custom_umount.sh"
$MODDIR/custom_umount.sh 2>&1 | tee umount.log

umount_dir 2>&1 | tee -a umount.log

umount_partition 2>&1 | tee -a umount.log
