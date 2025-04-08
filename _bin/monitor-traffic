#!/bin/bash

# Network interface to monitor (run 'ip a' to find yours)
INTERFACE="$(ip -o -4 route show to default | awk '{print $5}' | head -n1)"

# Function to get current network usage
get_network_usage() {
  local rx_bytes=$(cat /sys/class/net/$INTERFACE/statistics/rx_bytes)
  local tx_bytes=$(cat /sys/class/net/$INTERFACE/statistics/tx_bytes)
  echo "$rx_bytes $tx_bytes"
}

# First measurement
read rx_bytes1 tx_bytes1 <<< $(get_network_usage)

# Sleep to measure the difference
sleep 1

# Second measurement
read rx_bytes2 tx_bytes2 <<< $(get_network_usage)

# Calculate speeds
rx_speed=$((($rx_bytes2 - $rx_bytes1) / 1024))  # KB/s
tx_speed=$((($tx_bytes2 - $tx_bytes1) / 1024))  # KB/s

# Function to format network speed
format_speed() {
  local speed=$1
  if [ $speed -ge 1024 ]; then
    echo "$(echo "scale=1; $speed/1024" | bc)MB/s"
  else
    echo "${speed}KB/s"
  fi
}

# Format the output
rx_formatted=$(format_speed $rx_speed)
tx_formatted=$(format_speed $tx_speed)

# Display the result
echo "↓${rx_formatted} ↑${tx_formatted}"
