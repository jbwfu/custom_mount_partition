#!/system/bin/sh

init_conf() {
    . ${1}
    mountDir=$(echo "$mountDir" | sed 's/#[^ ]*//g')
}

mount_partition () {
    [[ ! -b "$partition" ]] && exit 1
    mkdir -p "$exsdRootDir"
    mount -t ext4 "$partition" "$exsdRootDir"
}

umount_partition () {
    umount "$exsdRootDir"
    rmdir "$exsdRootDir"
}

# 初始化挂载路径
init_dir () {
    [[ ! -d "$Source" && ! -d "$Target" ]] && mkdir -p "$Source" "$Target"
    if [[ ! -d "$Source" ]]; then
        [[ -f "$Source" ]] && (mv "$Source" "$Source".bak; mkdir -p "$Source")
        [[ true = "$moveMode" ]] && (rmdir "$Source"; mv "$Target" "$Source")
    fi
    [[ ! -d "$Target" ]] && mkdir -p "$Target"
}

broadcast_media() {
    am broadcast -a android.intent.action.MEDIA_SCANNER_SCAN_FILE -d file:///storage/emulated/0
}

mount_dir () {
    Source=$exsdRootDir/$1
    Target=$homeRootDir/$2
    umount_dir $2
    init_dir
    ug=$(stat -c "%U:%G" "$Target")
    rw=$(stat -c "%a" "$Target")
    reference=$(ls -Z "${Target%/*}" 2>/dev/null| grep "${Target##*/}"| cut -d' ' -f1)
    mount $mountParameters $Source $Target
    chown $ug "$Target" -R
    chmod $rw "$Target" -R
    chcon -R "$reference" "$Target"
    broadcast_media
}

umount_dir () {
    if [[ $# -eq 0 ]]; then
        for i in ${mountDir}; do
            umount $homeRootDir/${i#*;}
            mount| grep "/emulated/0/${i#*;}" |awk '{print $3}'| xargs umount
        done
    else
        umount $homeRootDir/$1
        mount| grep "/emulated/0/$1" |awk '{print $3}'| xargs umount
    fi
}

start_mount_dir() {
    for i in ${mountDir}; do
        mount_dir ${i%;*} ${i#*;}
    done
}
