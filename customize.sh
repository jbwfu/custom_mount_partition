
. "$MODPATH/function.sh"
init_conf "$MODPATH/conf"

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
    ui_print " 可修改模块 conf 文件后再次刷入"
    ui_print " 若 conf 文件无法满足挂载需求，可修改 custom_mount.sh 文件进行自定义挂载"
ui_print "*****************************************************"
