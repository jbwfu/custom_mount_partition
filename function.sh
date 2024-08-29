#!/system/bin/sh


user_id=$(basename $(realpath /storage/self/primary))
if [[ -z "$user_id" ]]; then exit 1; fi

init_conf() {
    source ${1}
    mountDir=$(echo "$mountDir" | sed 's/#[^ ]*//g')
}

broadcast_media() {
    dir=$(echo "$1" | sed "s#/data/media/$user_id#/sdcard#")
    dir=$(echo "$1" | sed "s#/mnt/pass_through/$user_id/emulated/$user_id#/sdcard#")
    am broadcast -a android.intent.action.MEDIA_SCANNER_SCAN_FILE -d "file://$dir" >/dev/null
}

mount_partition () {
    [[ ! -b "$partition" ]] && exit 1
    mkdir -p "$exsdRootDir"
    if [[ $(mount | grep -q "$exsdRootDir";echo $?) -eq 0 ]]; then
        echo "The path \""$exsdRootDir"\" is already a mount point"
        return 0
    fi
    
    mount -t ext4 "$partition" "$exsdRootDir"
    #chcon -R "$(get_attributes context)" "$exsdRootDir"
}

umount_partition () {
    umount_dir "$exsdRootDir"
    [[ -d "$exsdRootDir" ]] && rmdir "$exsdRootDir"
}

get_attributes() {
    # Maybe it doesn't need to be that complicated
    if [[ -n "$2" ]] && [[ -d "$2" ]]; then
        dir="$2"
    else
        dir="/data/media/$user_id"
    fi
    
    case "$1" in
        "owner")
            tmp=$(find "$dir" -maxdepth 1 -type d -not -name "$(basename "$dir")" -printf "%u:%g\n")
            ;;
        "context")
            tmp=$(ls -l -Z -1 "$dir" | awk '{print $5}')
            ;;
        "perms")
            tmp=$(find "$dir" -maxdepth 1 -type d -not -name "$(basename "$dir")" -printf "%m\n")
            ;;
        *)
            echo "Error: Invalid parameter \"$1\"" >&2
            return 1
    esac
    echo $tmp | xargs -n1 | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}'
}

check_mount_params() {
    [[ $(mkdir -p "$1" >/dev/null 2>&1;echo $?) -ne 0 ]] && return 1
    [[ $(mkdir -p "$2" >/dev/null 2>&1;echo $?) -ne 0 ]] && return 1
    return 0
}

mount_dir() {
    source="$1"
    target="$2"
    
    echo "Mount \"$source\" to \"$target\""
    if [[ $(mount | grep -q " $2 "; echo $?) -eq 0 ]]; then
        echo "$2 is mounted"
        return 0
    fi
    
    if ! [[ $(check_mount_params "$source" "$target"; echo $?) -eq 0 ]]; then
        echo "Does not meet mounting conditions."
        return 1
    fi

    # umount_dir "$target"
    owner=$(get_attributes "owner")
    context=$(get_attributes "context")
    perms=$(get_attributes "perms")
    # echo "owner=$owner\ncontext=$context\nperms=$perms"

    chown -R "$owner" "$source"
    chmod -R "$perms" "$source"
    chcon -R "$context" "$source"
    
    mount -o rw,seclabel,noatime,noexec "$source" "$target"
    # chown -R "$owner" "$target"
    # chmod -R "$perms" "$target"
    # chcon -R "$context" "$target"

    if [[ "$target" != "$(get_ex_path $target)" ]]; then
        mount_dir "$source" "$(get_ex_path $target)"
    fi
    broadcast_media "$target"
}

get_ex_path() {
    echo "$@" | sed "s#/data/media/$user_id#/mnt/pass_through/$user_id/emulated/$user_id#"
}

check_mount_status() { [[ -d "$1" ]] && [[ $(mount | grep -q " $1 "; echo $?) -eq 0 ]]; echo $?; }

umount_dir () {
    if [[ -z "$1" ]]; then
        for i in ${mountDir}; do
            umount_dir "${i#*;}"
        done
    else
        if [[ $(check_mount_status "$1") -eq 0 ]]; then
            echo "Umount \"$1\""
            umount "$1"
            if [[ $(check_mount_status "$1") -eq 0 ]]; then
                echo "Error: Umount failed, please ensure that the file is not in use."
                return 1
            fi
        fi
        [[ $(check_mount_status "$(get_ex_path $1)") -eq 0 ]] && umount_dir "$(get_ex_path $1)"
    fi
}

start_mount_dir() {
    for i in ${mountDir}; do
        mount_dir "${i%;*}" "${i#*;}"
    done
}
