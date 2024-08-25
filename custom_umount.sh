#!/system/bin/sh
# 此脚本在 umount.sh 脚本中优先执行
# 用于执行自定义挂载的卸载操作

MODDIR=$(dirname $(realpath $0))

. "$MODDIR/function.sh"
init_conf "$MODDIR/conf"

# chmod +x $MODDIR/custommount/custom_umount_example.sh
# $MODDIR/custommount/custom_umount_example.sh
