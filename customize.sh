ui_print "*****************************************************"
. "$MODPATH/function.sh"
rm "$MODPATH/init.sh"
MODPATH_ACTUAL=$(ui_print "$MODPATH" | sed 's#/data/adb/modules_update#/data/adb/modules#')
if [[ -f "$MODPATH_ACTUAL/conf" ]]; then
    ui_print "use config \"$MODPATH_ACTUAL/conf\" to update"
    . "$MODPATH_ACTUAL/conf"
    mountDir=$(echo "$mountDir" | sed '/^$/d')
fi
ui_print "update config \"$MODPATH/conf\""
update_config "$MODPATH/conf"
ui_print "cp \"$MODPATH/conf\" to \"$MODPATH_ACTUAL/conf\""
cp "$MODPATH/conf" "$MODPATH_ACTUAL/conf"
init_conf "$MODPATH/conf"

ui_print "*****************************************************"
if [[ ! -b "$partition" ]]; then
    ui_print " 分区 \"$partition\" 不存在，请使用 \"多系统工具箱\"进行分区"
    ui_print " 若自行分区，请配置 partition 变量"
ui_print "********************************"
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
    output_custom_scripts "$MODPATH"
    ui_print " 可修改模块目录内的 conf 文件后再次刷入"
    ui_print " 若 conf 文件无法满足挂载需求，可使用 custom_mount.sh 文件进行自定义挂载"
ui_print "*****************************************************"
