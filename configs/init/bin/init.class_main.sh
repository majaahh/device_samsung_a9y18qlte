#! /vendor/bin/sh
# start ril-daemon only for targets on which radio is present
baseband=`getprop ro.baseband`
sgltecsfb=`getprop persist.vendor.radio.sglte_csfb`
datamode=`getprop persist.vendor.data.mode`
qcrild_status=false

case "$baseband" in
    "apq" | "sda" | "qcs" )
    setprop ro.vendor.radio.noril yes
    stop ril-daemon
    stop vendor.ril-daemon
    stop vendor.qcrild
esac

case "$baseband" in
    "msm" | "csfb" | "svlte2a" | "mdm" | "mdm2" | "sglte" | "sglte2" | "dsda2" | "unknown" | "dsda3" | "sdm" | "sdx" | "sm6")

    # For older modem packages launch ril-daemon.
    if [ -f /vendor/firmware_mnt/verinfo/ver_info.txt ]; then
        modem=`cat /vendor/firmware_mnt/verinfo/ver_info.txt |
                sed -n 's/^[^:]*modem[^:]*:[[:blank:]]*//p' |
                sed 's/.*MPSS.\(.*\)/\1/g' | cut -d \. -f 1`
        if [ "$modem" = "AT" ]; then
            version=`cat /vendor/firmware_mnt/verinfo/ver_info.txt |
                    sed -n 's/^[^:]*modem[^:]*:[[:blank:]]*//p' |
                    sed 's/.*AT.\(.*\)/\1/g' | cut -d \- -f 1`
            if [ ! -z $version ]; then
                if [ "$version" \< "3.1" ]; then
                    qcrild_status=false
                fi
            fi
        elif [ "$modem" = "TA" ]; then
            version=`cat /vendor/firmware_mnt/verinfo/ver_info.txt |
                    sed -n 's/^[^:]*modem[^:]*:[[:blank:]]*//p' |
                    sed 's/.*TA.\(.*\)/\1/g' | cut -d \- -f 1`
            if [ ! -z $version ]; then
                if [ "$version" \< "3.0" ]; then
                    qcrild_status=false
                fi
            fi
        elif [ "$modem" = "JO" ]; then
            version=`cat /vendor/firmware_mnt/verinfo/ver_info.txt |
                    sed -n 's/^[^:]*modem[^:]*:[[:blank:]]*//p' |
                    sed 's/.*JO.\(.*\)/\1/g' | cut -d \- -f 1`
            if [ ! -z $version ]; then
                if [ "$version" \< "3.2" ]; then
                    qcrild_status=false
                fi
            fi
        elif [ "$modem" = "TH" ]; then
            qcrild_status=false
        fi
    fi

    if [ "$qcrild_status" = "true" ]; then
        # Make sure both rild, qcrild are not running at same time.
        # This is possible with vanilla aosp system image.
        stop ril-daemon
        stop vendor.ril-daemon

        start vendor.qcrild
    else
        start ril-daemon
        start vendor.ril-daemon
    fi

    case "$baseband" in
        "svlte2a" | "csfb")
          start qmiproxy
        ;;
        "sglte" | "sglte2" )
          if [ "x$sgltecsfb" != "xtrue" ]; then
              start qmiproxy
          else
              setprop persist.vendor.radio.voice.modem.index 0
          fi
        ;;
    esac

    multisim=`getprop persist.radio.multisim.config`

    if [ "$multisim" = "dsds" ] || [ "$multisim" = "dsda" ]; then
        if [ "$qcrild_status" = "true" ]; then
          start vendor.qcrild2
        else
          start vendor.ril-daemon2
        fi
    elif [ "$multisim" = "tsts" ]; then
        if [ "$qcrild_status" = "true" ]; then
          start vendor.qcrild2
          start vendor.qcrild3
        else
          start vendor.ril-daemon2
          start vendor.ril-daemon3
        fi
    fi

    case "$datamode" in
        "tethered")
            start vendor.dataqti
            start vendor.dataadpl
            ;;
        "concurrent")
            start vendor.dataqti
            start vendor.dataadpl
            ;;
        *)
            ;;
    esac
esac

#
# Allow persistent faking of bms
# User needs to set fake bms charge in persist.vendor.bms.fake_batt_capacity
#
fake_batt_capacity=`getprop persist.vendor.bms.fake_batt_capacity`
case "$fake_batt_capacity" in
    "") ;; #Do nothing here
    * )
    echo "$fake_batt_capacity" > /sys/class/power_supply/battery/capacity
    ;;
esac
