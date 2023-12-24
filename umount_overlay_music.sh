#!/bin/bash
#!/bin/bash

MODDIR=$(dirname $(realpath $0))

. "$MODDIR/function.sh"
init_conf "$MODDIR/conf"

# 音乐文件夹路径
lowerDirRoot="$exsdRootDir/Home/Music/Artist"

mergeddir="$exsdRootDir/Home/Music/merged"

mount | grep "$mergeddir" && umount "$mergeddir"

grepPara="-e netease/cloudmusic/Music"
mount| grep ^overlay| awk '{print $3}'| grep $grepPara| xargs umount
