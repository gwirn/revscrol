#!/bin/bash
sleep 10
mice=('MX Anywhere 2S' 'MX Master 3S')
revscrolPath="$HOME/Code/revscrol"
runtime="5M"

externalMouseDetected=1

endtime=$(date -u -v "+$runtime" +%s)
while [[ $(date -u +%s) -le $endtime ]];do
    for m in "${mice[@]}";do
        if  ! system_profiler SPBluetoothDataType | grep -B1000 "$m" | grep -qi 'Not Connected' ;then
            externalMouseDetected=0
            break
        fi
    done
    if [ "$externalMouseDetected" -eq 0 ];then
        break
    fi
    sleep 5
done

if [ "$externalMouseDetected" -eq 1 ];then
    exit 0
fi
if [ "$(defaults read -g com.apple.swipescrolldirection)" -eq 1 ]; then
    if ! pgrep revscrol > /dev/null; then
        "$revscrolPath/revscrol" &> "$revscrolPath/revscrol.log" &
        echo "$!" > "$revscrolPath/revscrol.pid"
    fi
fi
