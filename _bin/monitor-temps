#!/bin/bash

# Get hostname
HOSTNAME=$(hostname)

# Different handling based on hostname
if [ "$HOSTNAME" = "oberon" ]; then
    # For Oberon - use k10temp with Tdie or Tctl
    if sensors | grep -q "k10temp"; then
        # Try to get Tdie first (more accurate) if available
        if sensors | grep -q "Tdie"; then
            cpu_temp=$(sensors | grep "Tdie" | awk '{print $2}' | sed 's/+//' | sed 's/°C//')
        else
            # Fall back to Tctl
            cpu_temp=$(sensors | grep "Tctl" | awk '{print $2}' | sed 's/+//' | sed 's/°C//')
        fi
    else
        cpu_temp="N/A"
    fi
elif [ "$HOSTNAME" = "deimos" ]; then
    # For Deimos - use coretemp Package id
    if sensors | grep -q "coretemp"; then
        cpu_temp=$(sensors | grep "Package id 0" | awk '{print $4}' | sed 's/+//' | sed 's/°C//')
    else
        cpu_temp="N/A"
    fi
else
    # Default fallback for any other hostname
    if sensors | grep -q "k10temp"; then
        cpu_temp=$(sensors | grep -A 0 "k10temp" | grep "Tctl" | awk '{print $2}' | sed 's/+//' | sed 's/°C//')
    elif sensors | grep -q "coretemp"; then
        cpu_temp=$(sensors | grep "Package id 0" | awk '{print $4}' | sed 's/+//' | sed 's/°C//')
    else
        cpu_temp="N/A"
    fi
fi

# Get CPU fan speed - works for both systems
cpu_fan="N/A"
if sensors | grep -q "CPU Fan"; then
    cpu_fan=$(sensors | grep "CPU Fan" | awk '{print $3}')
elif sensors | grep -q "fan1"; then
    cpu_fan=$(sensors | grep "fan1" | awk '{print $2}')
fi

# Get GPU info with universal detection
if sensors | grep -q "amdgpu"; then
    # For AMD GPU
    gpu_temp=$(sensors | grep "edge" | awk '{print $2}' | sed 's/+//' | sed 's/°C//')
    gpu_fan=$(sensors | grep -A 10 "amdgpu" | grep "fan1" | awk '{print $2}')
    echo "CPU: ${cpu_temp}°C (${cpu_fan}RPM) | GPU: ${gpu_temp}°C (${gpu_fan}RPM)"
elif command -v nvidia-smi &> /dev/null; then
    # For NVIDIA GPU
    gpu_temp=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)
    
    # Check if fan speed reporting is supported
    if nvidia-smi --query-gpu=fan.speed --format=csv,noheader 2>/dev/null | grep -q -v "N/A"; then
        gpu_fan=$(nvidia-smi --query-gpu=fan.speed --format=csv,noheader)
        echo "CPU: ${cpu_temp}°C (${cpu_fan}RPM) | GPU: ${gpu_temp}°C (${gpu_fan})"
    else
        # If fan speed isn't available
        echo "CPU: ${cpu_temp}°C (${cpu_fan}RPM) | GPU: ${gpu_temp}°C"
    fi
else
    # No GPU found
    echo "CPU: ${cpu_temp}°C (${cpu_fan}RPM)"
fi

