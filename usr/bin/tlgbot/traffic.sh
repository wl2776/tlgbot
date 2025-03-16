#!/bin/sh

luci-bwc -i wan > /dev/null
sleep 3

luci-bwc -i wan | tr '[],' ' '  |\
 awk 'BEGIN{ start_time=systime() - 3 }
      { if ($1 == start_time ) {
            rx_bytes_start = $2
            tx_bytes_start = $4
        }
        if ($1 > start_time) {
            end_time = $1
            rx_bytes_end = $2
            tx_bytes_end = $4
        }
      }
      END{ printf("RX: %5.2f bps, TX: %5.2f bps\n", 
                  (rx_bytes_end - rx_bytes_start) / (end_time - start_time),
                  (tx_bytes_end - tx_bytes_start) / (end_time - start_time) ) }'
