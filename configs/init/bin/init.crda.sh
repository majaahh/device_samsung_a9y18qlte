#! /vendor/bin/sh

country=`getprop wlan.crda.country`
# crda takes input in COUNTRY environment variable
[[ -n $country ]] && COUNTRY="$country" /system/bin/crda
