#! /vendor/bin/sh

export PATH=/vendor/bin

# Set platform variables
if [[ -f /sys/devices/soc0/hw_platform ]]; then
    soc_hwplatform=`cat /sys/devices/soc0/hw_platform` 2> /dev/null
else
    soc_hwplatform=`cat /sys/devices/system/soc/soc0/hw_platform` 2> /dev/null
fi
if [[ -f /sys/devices/soc0/soc_id ]]; then
    soc_hwid=`cat /sys/devices/soc0/soc_id` 2> /dev/null
else
    soc_hwid=`cat /sys/devices/system/soc/soc0/id` 2> /dev/null
fi
if [[ -f /sys/devices/soc0/platform_version ]]; then
    soc_hwver=`cat /sys/devices/soc0/platform_version` 2> /dev/null
else
    soc_hwver=`cat /sys/devices/system/soc/soc0/platform_version` 2> /dev/null
fi

if [[ -f /sys/class/drm/card0-DSI-1/modes ]]; then
    echo "detect" > /sys/class/drm/card0-DSI-1/status
    mode_file=/sys/class/drm/card0-DSI-1/modes
    while read line; do
        fb_width=${line%%x*};
        break;
    done < $mode_file
elif [ -f /sys/class/graphics/fb0/virtual_size ]; then
    res=`cat /sys/class/graphics/fb0/virtual_size` 2> /dev/null
    fb_width=${res%,*}
fi

log -t BOOT -p i "MSM target '$1', SoC '$soc_hwplatform', HwID '$soc_hwid', SoC ver '$soc_hwver'"

# For drm based display driver
vbfile=/sys/module/drm/parameters/vblankoffdelay
if [[ -w $vbfile ]]; then
    echo -1 >  $vbfile
else
    log -t DRM_BOOT -p w "file: '$vbfile' or perms doesn't exist"
fi

function set_density_by_fb() {
    # put default density based on width
    if [[ -z $fb_width ]]; then
        setprop vendor.display.lcd_density 320
    else
        if [[ $fb_width -ge 1600 ]]; then
           setprop vendor.display.lcd_density 640
        elif [[ $fb_width -ge 1440 ]]; then
           setprop vendor.display.lcd_density 560
        elif [[ $fb_width -ge 1080 ]]; then
           setprop vendor.display.lcd_density 480
        elif [[ $fb_width -ge 720 ]]; then
           setprop vendor.display.lcd_density 320
        elif [[ $fb_width -ge 480 ]]; then
            setprop vendor.display.lcd_density 240
        else
            setprop vendor.display.lcd_density 160
        fi
    fi
}

case "$soc_hwid" in
    385)
        setprop vendor.media.target.version 1
esac

baseband=`getprop ro.baseband`
# enable atfwd daemon all targets except sda, apq, qcs
case "$baseband" in
    "apq" | "sda" | "qcs" )
        setprop persist.vendor.radio.atfwd.start false;;
    *)
        setprop persist.vendor.radio.atfwd.start true;;
esac

set_density_by_fb


# set Lilliput LCD density for ADP
product=`getprop ro.build.product`

case "$product" in
        "msmnile_au")
         setprop vendor.display.lcd_density 160
         echo 902400000 > /sys/class/devfreq/soc:qcom,cpu0-cpu-l3-lat/min_freq
         echo 1612800000 > /sys/class/devfreq/soc:qcom,cpu0-cpu-l3-lat/max_freq
         echo 902400000 > /sys/class/devfreq/soc:qcom,cpu4-cpu-l3-lat/min_freq
         echo 1612800000 > /sys/class/devfreq/soc:qcom,cpu4-cpu-l3-lat/max_freq
         ;;
        *)
        ;;
esac
case "$product" in
        "sm6150_au")
         setprop vendor.display.lcd_density 160
         ;;
        *)
        ;;
esac
case "$product" in
        "sdmshrike_au")
         setprop vendor.display.lcd_density 160
         echo 940800000 > /sys/class/devfreq/soc:qcom,cpu0-cpu-l3-lat/min_freq
         echo 940800000 > /sys/class/devfreq/soc:qcom,cpu4-cpu-l3-lat/min_freq
         ;;
        *)
        ;;
esac

case "$product" in
        "msmnile_gvmq")
         setprop vendor.display.lcd_density 160
         ;;
        *)
        ;;
esac
# Setup display nodes & permissions
# HDMI can be fb1 or fb2
# Loop through the sysfs nodes and determine
# the HDMI(dtv panel)

function set_perms() {
    #Usage set_perms <filename> <ownership> <permission>
    chown -h $2 $1
    chmod $3 $1
}

# check for the type of driver FB or DRM
fb_driver=/sys/class/graphics/fb0
if [ -e "$fb_driver" ]
then
    # check for mdp caps
    file=/sys/class/graphics/fb0/mdp/caps
    if [ -f "$file" ]
    then
        setprop vendor.gralloc.disable_ubwc 1
        cat $file | while read line; do
          case "$line" in
                    *"ubwc"*)
                    setprop vendor.gralloc.enable_fb_ubwc 1
                    setprop vendor.gralloc.disable_ubwc 0
                esac
        done
    fi
else
    set_perms /sys/devices/virtual/hdcp/msm_hdcp/min_level_change system.graphics 0660
fi

# allow system_graphics group to access pmic secure_mode node
set_perms /sys/class/lcd_bias/secure_mode system.graphics 0660
set_perms /sys/class/leds/wled/secure_mode system.graphics 0660

boot_reason=`cat /proc/sys/kernel/boot_reason`
reboot_reason=`getprop ro.boot.alarmboot`
if [[ "$boot_reason" = "3" ]] || [[ "$reboot_reason" = "true" ]]; then
    setprop ro.vendor.alarm_boot true
else
    setprop ro.vendor.alarm_boot false
fi

# copy GPU frequencies to vendor property
if [[ -f /sys/class/kgsl/kgsl-3d0/gpu_available_frequencies ]]; then
    gpu_freq=`cat /sys/class/kgsl/kgsl-3d0/gpu_available_frequencies` 2> /dev/null
    setprop vendor.gpu.available_frequencies "$gpu_freq"
fi
