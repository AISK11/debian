#!/bin/bash

# Author: AISK11
# Description: This script calculates network throughput for interface "eth0" in b/s every second.
# 1 MB/s = 8 Mb/s
# 1 Mb/s = 1,000 kb/s = 1,000,000 b/s
# Created for: i3blocks
# Dependencies: iproute2 wireless-tools

# interfaces=<eth0|wlan0|lo>
INTERFACE="eth0"
INTERFACE_STATE=$(ip a | grep ${INTERFACE} | grep -v "inet" | cut -d' ' -f9)

# Channel is not workign with i3blocks :(
#CHANNEL=$(iwconfig ${INTERFACE} | egrep -o "[0-9].*GHz")

if [ "${INTERFACE_STATE}" = "DOWN" ]
then
    echo "DOWN"
    echo "DOWN"
    echo "#FF4A4A"
elif [ "${INTERFACE_STATE}" = "UP" ]
then
    RX_OLD=$(cat /sys/class/net/${INTERFACE}/statistics/rx_bytes)
    TX_OLD=$(cat /sys/class/net/${INTERFACE}/statistics/tx_bytes)
    sleep 1
    RX_NEW=$(cat /sys/class/net/${INTERFACE}/statistics/rx_bytes)
    TX_NEW=$(cat /sys/class/net/${INTERFACE}/statistics/tx_bytes)
    RX_BYTES=$(( ${RX_NEW} - ${RX_OLD} ))
    TX_BYTES=$(( ${TX_NEW} - ${TX_OLD} ))
    # Debug # echo "RX ${RX_BYTES} B/s; TX ${TX_BYTES} B/s"
    RX_BITS=$(( ${RX_BYTES} * 8))
    TX_BITS=$(( ${TX_BYTES} * 8))


    if [ "${TX_BITS}" -ge "1000000" ] || [ "${RX_BITS}" -ge "1000000" ]
    then
        RX_BITS=$(( ${RX_BITS} / 1000000 ))
        TX_BITS=$(( ${TX_BITS} / 1000000 ))
        # Add leading space in front of variable:
        if [ ${#RX_BITS} -eq 1 ]; then
            RX_BITS="  ${RX_BITS}"
        elif [ ${#RX_BITS} -eq 2 ]; then
            RX_BITS=" ${RX_BITS}"
        fi 
        if [ ${#TX_BITS} -eq 1 ]; then
            TX_BITS="  ${TX_BITS}"
        elif [ ${#TX_BITS} -eq 2 ]; then
            TX_BITS=" ${TX_BITS}"
        fi 
        echo " ${RX_BITS} Mb/s  ${TX_BITS} Mb/s"
    elif [ "${TX_BITS}" -ge "1000" ] || [ "${RX_BITS}" -ge "1000" ]
    then
        RX_BITS=$(( ${RX_BITS} / 1000 )) 
        TX_BITS=$(( ${TX_BITS} / 1000 ))
        # Add leading space in front of variable:
        if [ ${#RX_BITS} -eq 1 ]; then
            RX_BITS="  ${RX_BITS}"
        elif [ ${#RX_BITS} -eq 2 ]; then
            RX_BITS=" ${RX_BITS}"
        fi 
        if [ ${#TX_BITS} -eq 1 ]; then
            TX_BITS="  ${TX_BITS}"
        elif [ ${#TX_BITS} -eq 2 ]; then
            TX_BITS=" ${TX_BITS}"
        fi 
        echo " ${RX_BITS} kb/s  ${TX_BITS} kb/s"
    else
        # Add leading space in front of variable:
        if [ ${#RX_BITS} -eq 1 ]; then
            RX_BITS="  ${RX_BITS}"
        elif [ ${#RX_BITS} -eq 2 ]; then
            RX_BITS=" ${RX_BITS}"
        fi 
        if [ ${#TX_BITS} -eq 1 ]; then
            TX_BITS="  ${TX_BITS}"
        elif [ ${#TX_BITS} -eq 2 ]; then
            TX_BITS=" ${TX_BITS}"
        fi 
        echo " ${RX_BITS}  b/s  ${TX_BITS}  b/s"
    fi
else
    echo "UNKNOWN"
    echo "UNKNOWN"
    echo "#FF4A4A"
fi
