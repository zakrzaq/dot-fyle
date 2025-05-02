#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]; then 
    echo "Please run as root"
    exit 1
fi

# Get UUID of swapfile
SWAP_UUID=$(findmnt -no UUID -T /swapfile)
SWAP_OFFSET=$(filefrag -v /swapfile | awk '$1=="0:" {print $4}' | tr -d '.')

# Backup initramfs config
cp /etc/initramfs-tools/conf.d/resume /etc/initramfs-tools/conf.d/resume.bak 2>/dev/null

# Configure resume
echo "RESUME=UUID=${SWAP_UUID}" > /etc/initramfs-tools/conf.d/resume

# Add resume offset to kernel parameters
if ! grep -q "resume_offset=${SWAP_OFFSET}" /etc/default/grub; then
    sed -i "s/GRUB_CMDLINE_LINUX_DEFAULT=\"/GRUB_CMDLINE_LINUX_DEFAULT=\"resume_offset=${SWAP_OFFSET} /" /etc/default/grub
fi

# Update initramfs and grub
update-initramfs -u
update-grub

# Verify swap is available
if ! swapon --show | grep -q /swapfile; then
    echo "Warning: Swap file not currently in use. Please ensure swap is enabled."
    echo "You can enable it with: swapon /swapfile"
fi

# Test hibernate is available
if [ -f /sys/power/state ] && grep -q disk /sys/power/state; then
    echo "Hibernate appears to be properly configured"
else
    echo "Warning: Hibernate may not be available on this system"
fi

echo "Setup complete. Please reboot to apply changes."
echo "After reboot, test hibernate with: systemctl hibernate"
