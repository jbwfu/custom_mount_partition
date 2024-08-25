#!/system/bin/sh
# 此脚本在 mount.sh 脚本中最后执行
# 可用于执行自定义挂载

MODDIR=$(dirname $(realpath $0))

. "$MODDIR/function.sh"
init_conf "$MODDIR/conf"

# chmod +x $MODDIR/custommount/custom_mount_example.sh
# $MODDIR/custommount/custom_mount_example.sh
