#!/bin/sh

interfaces=$(iw dev | awk '/Interface/{print $2}')

for wifi in $interfaces
do
    ssid=$(iw dev ${wifi} info | awk '/ssid/{print $2}')
    echo -en "--- ${wifi} ${ssid} ---\n"
    macaddr=$(iw dev ${wifi} station dump | awk '/Station/{print $2}')

    for lease in ${macaddr}
    do
        line=$(cat /tmp/dhcp.leases | grep ${lease})
        if [ $? == 0 ]; then
            echo "${line}" | awk '{gsub( "*","\\*" ); gsub( "_","\\_" ); printf "Устройство: " $4 "\nIP: " $3 "\nMAC: " toupper($2) "\n"}'
        else
            cat /proc/net/arp | grep ${lease} | awk '{gsub( "_","\\_" ); printf "IP: " $1 "\nMAC: " toupper($4) "\n"}'
        fi
        #/usr/bin/tlgbot/functions/get_mac.sh "${lease}"
        echo -en "\n"
    done
done
echo -e "\n"
