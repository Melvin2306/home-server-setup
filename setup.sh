#!/bin/bash

# Update package lists
echo "Updating package lists..."
sudo apt update
echo "Package lists updated."

# Upgrade installed packages
echo "Upgrading installed packages..."
sudo apt upgrade -y
echo "Installed packages upgraded."

# Install Docker Compose
echo "Installing Docker Compose..."
sudo apt install docker-compose -y
echo "Docker Compose installed."

# Create directories
echo "Creating directories..."
mkdir -p ~/nas ~/nextcloud ~/pihole ~/docker ~/cloudflare ~/jellyfin ~/change-detection
echo "Directories created."

# Mount NAS
echo "Mounting NAS..."

# Find the device name of the first USB device
USB_DEVICE=$(lsblk -o NAME,MOUNTPOINT | grep -v "boot\|root" | awk '/\/media\//{print $1}' | head -n 1)

if [ -z "$USB_DEVICE" ]; then
    echo "No USB device detected."
    exit 1
fi

# The full path of the device
USB_DEVICE_PATH="/dev/$USB_DEVICE"

# Directory to mount the USB device
MOUNT_DIR="$HOME/nas"

# Check if the mount directory exists
if [ ! -d "$MOUNT_DIR" ]; then
    echo "Mount directory $MOUNT_DIR does not exist, creating it..."
    mkdir -p "$MOUNT_DIR"
fi

# Mount the USB device
echo "Mounting $USB_DEVICE_PATH to $MOUNT_DIR..."
sudo mount $USB_DEVICE_PATH $MOUNT_DIR

if [ $? -eq 0 ]; then
    echo "Successfully mounted $USB_DEVICE_PATH to $MOUNT_DIR."
else
    echo "Failed to mount $USB_DEVICE_PATH."
fi

# Move docker-compose files to directories
echo "Moving docker-compose files to directories..."
mv ~/pihole/docker-compose.yml ~/pihole/docker-compose.yml
mv ~/jellyfin/docker-compose.yml ~/jellyfin/docker-compose.yml
mv ~/change-detection/docker-compose.yml ~/change-detection/docker-compose.yml
echo "Docker-compose files moved."

# Execute docker-compose files
echo "Executing docker-compose files..."
cd ~/pihole
sudo docker-compose up -d
cd ~/jellyfin
sudo docker-compose up -d
cd ~/change-detection
sudo docker-compose up -d
echo "Docker-compose files executed."

# Check if docker-compose files are running
echo "Checking if docker-compose files are running..."
sudo docker ps
echo "Docker-compose files are running."

# Reboot system
echo "Setup Script execution completed successfully. Reboorting system..."
sudo reboot