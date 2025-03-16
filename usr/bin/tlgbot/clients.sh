#!/bin/sh

arp-scan -l --interface=br-lan --macfile=/usr/share/arp-scan/mac-vendor.txt --format '${IP;14} ${Mac} ${Name}' --resolve --plain

