#!/system/bin/sh

MODDIR=$(dirname $(realpath $0))

wait_start=1
until [[ $(getprop sys.boot_completed) -eq 1 && $(dumpsys window policy | grep "mInputRestricted" | cut -d= -f2) = false ]]; do
    sleep 1
    [[ $wait_start -ge 180 ]] && exit 1
    let wait_start++
done

sleep 5

chmod +x $MODDIR/mount.sh
$MODDIR/mount.sh

chmod +x $MODDIR/custom_mount.sh
$MODDIR/custom_mount.sh
