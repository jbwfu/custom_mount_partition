ui_print "*****************************************************"
. "$MODPATH/function.sh"
MODPATH_ACTUAL=$(ui_print "$MODPATH" | sed 's#/data/adb/modules_update#/data/adb/modules#')
if [[ -f "$MODPATH_ACTUAL/conf" ]]; then
    ui_print "use config \"$MODPATH_ACTUAL/conf\" to update"
    . "$MODPATH_ACTUAL/conf"
fi
ui_print "update config \"$MODPATH/conf\""
update_config "$MODPATH/conf"
cp "$MODPATH/conf" "$MODPATH_ACTUAL/conf"
init_conf "$MODPATH/conf"

output_custom_scripts() {
if [[ -f "$MODPATH_ACTUAL/custom_mount.sh" ]]; then
    cp "$MODPATH_ACTUAL/custom_mount.sh" "$MODPATH/custom_mount.sh"
else
cat << EOF > "$MODPATH/custom_mount.sh"
#!/system/bin/sh
# 此脚本在 mount.sh 脚本中最后执行
# 可用于执行自定义挂载

# MODDIR=\$(dirname \$(realpath \$0))

# . "\$MODDIR/function.sh"
# init_conf

# chmod +x \$MODDIR/custommount/custom_mount_example.sh
# \$MODDIR/custommount/custom_mount_example.sh

EOF
fi

if [[ -f "$MODPATH_ACTUAL/custom_umount.sh" ]]; then
    cp "$MODPATH_ACTUAL/custom_umount.sh" "$MODPATH/custom_umount.sh"
else
cat << EOF > "$MODPATH/custom_umount.sh"
#!/system/bin/sh
# 此脚本在 umount.sh 脚本中优先执行
# 用于执行自定义挂载的卸载操作

# MODDIR=\$(dirname \$(realpath \$0))

# . "\$MODDIR/function.sh"
# init_conf

# chmod +x \$MODDIR/custommount/custom_umount_example.sh
# \$MODDIR/custommount/custom_umount_example.sh

EOF
fi

if [[ -d "$MODPATH_ACTUAL/custommount" ]]; then
    cp -r "$MODPATH_ACTUAL/custommount" "$MODPATH/"
else
    mkdir "$MODPATH/custommount"
fi
}

ui_print "*****************************************************"
if [[ ! -b "$partition" ]]; then
    ui_print " 分区 \"$partition\" 不存在，请使用 \"多系统工具箱进行分区\""
    ui_print " 若自行分区，请修改脚本 conf 文件 "
abort "*****************************************************"
fi

ui_print " 待挂载分区：$partition"
ui_print " 分区挂载点：$exsdRootDir"

ui_print "********************* 文件夹挂载 *********************"
if [[ -z "$mountDir" ]]; then
    ui_print " 文件夹挂载未配置"
else
    for i in ${mountDir}; do
        ui_print " \"${i%;*}\" --> \"${i#*;}\""
    done
fi
ui_print "*****************************************************"
    output_custom_scripts
    ui_print " 可修改模块 conf 文件后再次刷入"
    ui_print " 若 conf 文件无法满足挂载需求，可修改 custom_mount.sh 文件进行自定义挂载"
ui_print "*****************************************************"
