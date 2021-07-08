#!/bin/bash

# Author: AISK11
# Description: This script calculates network throughput for interface "wlan0" in b/s every second.
# 1 MB/s = 8 Mb/s
# 1 Mb/s = 1,000 kb/s = 1,000,000 b/s
# Created for: i3blocks
# Dependencies: iproute2 wireless-tools

# interfaces=<wlan0|wlp0s20f3>
INTERFACE="wlan0"
INTERFACE_STATE=$(ip a | grep ${INTERFACE} | grep -v "inet" | cut -d' ' -f9)

CHANNEL=$(iwlist ${INTERFACE} channel | grep "Current" | tr -s " " | cut -d " " -f 3,4 | tr "=" ":" | cut -d ":" -f2)

if [ "${INTERFACE_STATE}" = "DOWN" ]
then
    printf "DOWN\n"
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
        echo "RX ${RX_BITS} Mb/s; TX ${TX_BITS} Mb/s (${CHANNEL})"
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
        echo "RX ${RX_BITS} Mb/s; TX ${TX_BITS} Mb/s (${CHANNEL})"
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
        echo "RX ${RX_BITS} Mb/s; TX ${TX_BITS} Mb/s (${CHANNEL})"
    fi
else
    printf "UNKNOWN\n"
fi