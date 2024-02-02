# Project Setup Scripts

This repository contains scripts designed to streamline the setup of a server environment, including software updates, Docker Compose installation, directory creation, and USB device mounting. This script is mainly desinged to be used on a Raspberry Pi but can also be used on any other Linux-based computer using the ARM CPU architecture.

## Scripts Overview

- `setup.sh`: This script updates the system's package lists, upgrades installed packages, installs Docker Compose, detects a connected USB device and mounts it to the `nas` directory in the user's home folder and creates specific directories in the user's home folder.

## Getting Started

### Prerequisites

- A Linux-based system with ARM architecture with sudo privileges.
- USB device (for mount part of the script).

### Installation

1. Install git:

   ```
   sudo apt install git -y
   ```

2. Clone the repository to your local machine:

   ```
   git clone https://github.com/Melvin2306/home-server-setup
   ```

3. Navigate to the cloned repository's directory:

   ```
   cd home-server-setup
   ```

4. Give execution permissions to the scripts:

   ```
   chmod +x setup.sh
   ```

### Usage

1. **Setup Environment**: Run the `setup_environment.sh` script to update the system, install Docker Compose, and create the necessary directories.

   ```
   sudo ./setup.sh
   ```

   This script requires sudo access to perform updates and installations. Before running the script, ensure a USB device is connected to the system. 

## Contributing

Contributions to improve the scripts or add new features are welcome. Please follow the standard GitHub pull request process to submit your contributions.

## Services

The following services are installed through this script:

- Changedetection.io

Changedetection.io is a web application that can be used to monitor websites and detect changes in their source code. For further information visit the official website [changedetection.io](https://changedetection.io/)

- Pi-hole

Pi-hole is DNS Service that you can use to filter malicious websites and ads from your traffic. Add custom domains or wordlists you can find online to improve and expand your lists of blocked domains. Find more information on the official website [pi-hole.net](https://pi-hole.net/)

- Jellyfin

Jellyfin is a web application that makes it possible to watch your own movies and tv-shows from every device in your network. It expands the streaming experience by adding metadata to the movies and shows. Find more information on the official website [jellyfin.org](https://jellyfin.org/)