#!/vendor/bin/sh
abnormalcnt="persist.vendor.crash.cnt"

abnormal_cnt=`getprop $abnormalcnt`
crash_detect=`getprop persist.vendor.crash.detect`

[[ -n "$abnormal_cnt" ]] && setprop $abnormalcnt 0

if [ "$crash_detect" = "true" ]; then
    abnormal_cnt=`expr $abnormal_cnt + 1`
    setprop $abnormalcnt $abnormal_cnt
else
    setprop persist.vendor.crash.detect true
fi
