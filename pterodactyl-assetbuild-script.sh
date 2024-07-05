#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Create directory for apt keyrings
sudo mkdir -p /etc/apt/keyrings

# Add the NodeSource GPG key
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg

# Add the NodeSource repository
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_16.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list

# Update package lists
sudo apt update

# Install NodeJS
sudo apt install -y nodejs

# Install npm
sudo apt install -y npm

# Install Yarn globally
npm i -g yarn

# Navigate to the Panel directory
cd /var/www/pterodactyl

# Install the Panel build dependencies
yarn

# Set Node options if using NodeJS version 17 or above
export NODE_OPTIONS=--openssl-legacy-provider

# Build the Panel assets
yarn build:production

echo "Panel assets have been successfully built."
