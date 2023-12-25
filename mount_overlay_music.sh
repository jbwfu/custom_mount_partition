#!/system/bin/sh

MODDIR=$(dirname $(realpath $0))

. "$MODDIR/function.sh"
init_conf "$MODDIR/conf"

# 音乐文件夹路径
lowerDirRoot="$exsdRootDir/Home/Music/Artist"

workdir="$exsdRootDir/Home/Music/work"
upperdir="$exsdRootDir/Home/Music/diff"
mergeddir="$exsdRootDir/Home/Music/merged"

# 解挂载
. $MODDIR/umount_overlay_music.sh

lowerdir=""
for dir in "$lowerDirRoot"/*; do
    if [ -d "$dir" ]; then
        if [ -z "$lowerdir" ]; then
            lowerdir="$dir"
        else
            lowerdir="$lowerdir:$dir"
        fi
    fi
done

# 创建所需目录，如果它不存在的话
mkdir -p "$workdir" "$upperdir" "$mergeddir"

# 权限设置
reference=$(ls -Z "${mergeddir%/*}" 2>/dev/null| grep "${mergeddir##*/}"| cut -d' ' -f1)
chcon -R "$reference" "$lowerDirRoot" "$upperdir" "$mergeddir"

chcon u:hidden_object:s0 "$workdir" "$lowerDirRoot"
# chcon u:object_r:media_rw_data_file:s0 -R "$lowerDirRoot" "$upperdir" "$mergeddir"
# chcon u:object_r:sdcardfs:s0 -R "$lowerDirRoot" "$upperdir" "$mergeddir"

# 挂载 overlay
mount -t overlay overlay -o lowerdir="$lowerdir",upperdir="$upperdir",workdir="$workdir" "$mergeddir"

# 挂载至 /sdcard/
mkdir -p "$homeRootDir/netease/cloudmusic/Music"
mount -o noatime --bind "$mergeddir" "$homeRootDir/netease/cloudmusic/Music"

