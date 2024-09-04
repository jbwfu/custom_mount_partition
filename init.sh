#!/system/bin/sh

MODDIR="$(dirname $(realpath $0))"
. "$MODDIR/function.sh"

update_config "$MODDIR/conf"
output_custom_scripts
rm "$MODDIR/customize.sh"
rm -rf "$MODDIR/META-INF"
rm "$MODDIR/init.sh"
