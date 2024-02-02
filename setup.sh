#!/bin/bash

# Update package lists
echo "Updating package lists..."
if sudo apt update; then
    echo "Package lists updated."
else
    echo "Error updating package lists."
    exit 1
fi

# Upgrade installed packages
echo "Upgrading installed packages..."
if sudo apt upgrade -y; then
    echo "Installed packages upgraded."
else
    echo "Error upgrading installed packages."
    exit 1
fi

# Install Docker Compose
echo "Installing Docker Compose..."
if sudo apt install docker-compose -y; then
    echo "Docker Compose installed."
else
    echo "Error installing Docker Compose."
    exit 1
fi

# Create directories
echo "Creating directories..."
cd ..
if mkdir -p nas nextcloud pihole docker cloudflare jellyfin change-detection; then
    echo "Directories created."
else
    echo "Error creating directories."
    exit 1
fi

# Prompt user for Pi-hole WEBPASSWORD
echo -n "Enter the password for Pi-hole's Web interface and press [ENTER]: "
read WEBPASSWORD

# Check if WEBPASSWORD is empty
if [ -z "$WEBPASSWORD" ]; then
    echo "WEBPASSWORD cannot be empty."
    exit 1
fi

# Move docker-compose files to directories
echo "Moving docker-compose files to directories..."
if mv home-server-setup/pihole/docker-compose.yml pihole/ && \
   rm -r home-server-setup/pihole && \
   sed -i "s/WEBPASSWORD: \"jellyfin\"/WEBPASSWORD: \"$WEBPASSWORD\"/g" jellyfin/docker-compose.yml && \
   mv home-server-setup/jellyfin/docker-compose.yml jellyfin/ && \
   rm -r home-server-setup/jellyfin && \
   mv home-server-setup/change-detection/docker-compose.yml change-detection/ && \
   rm -r home-server-setup/change-detection; then
    echo "Docker-compose files moved and Pi-hole password set."
else
    echo "Error moving Docker-compose files or setting Pi-hole password."
    exit 1
fi

# Execute docker-compose files
echo "Executing docker-compose files..."
cd pihole && sudo docker-compose up -d && cd ..
cd jellyfin && sudo docker-compose up -d && cd ..
cd change-detection && sudo docker-compose up -d && cd ..
echo "Docker-compose files executed."

# Check if docker-compose files are running
echo "Checking if docker-compose files are running..."
if sudo docker ps; then
    echo "Docker-compose files are running."
else
    echo "Error checking Docker-compose files."
fi

# Ending message
echo "Setup Script execution completed successfully!"