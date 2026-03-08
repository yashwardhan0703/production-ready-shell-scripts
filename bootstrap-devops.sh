#!/bin/bash

set -e

echo "======================================"
echo "   DevOps Server Bootstrap Script"
echo "======================================"

echo "Updating system..."
sudo apt update -y

echo "Installing basic packages..."
sudo apt install -y curl wget git apt-transport-https ca-certificates gnupg lsb-release

echo "--------------------------------------"
echo "Installing Docker..."
echo "--------------------------------------"

if command -v docker &> /dev/null
then
    echo "Docker already installed."
else
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker.gpg

    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] \
    https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update -y
    sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

    sudo systemctl enable docker
    sudo systemctl start docker

    sudo usermod -aG docker $USER

    echo "Docker installed successfully."
fi

echo "--------------------------------------"
echo "Installing Docker Compose..."
echo "--------------------------------------"

if docker compose version &> /dev/null
then
    echo "Docker Compose already available."
else
    sudo apt install docker-compose-plugin -y
    echo "Docker Compose installed."
fi

echo "--------------------------------------"
echo "Installing Nginx..."
echo "--------------------------------------"

if command -v nginx &> /dev/null
then
    echo "Nginx already installed."
else
    sudo apt install -y nginx
    sudo systemctl enable nginx
    sudo systemctl start nginx
    echo "Nginx installed and started."
fi

echo "--------------------------------------"
echo "SSH Key Generation (Optional)"
echo "--------------------------------------"

read -p "Do you want to generate an SSH key for GitHub? (y/n): " choice

if [[ "$choice" == "y" || "$choice" == "Y" ]]; then
    read -p "Enter your email for SSH key: " email
    ssh-keygen -t ed25519 -C "$email"

    echo ""
    echo "Your public SSH key:"
    echo "--------------------------------------"
    cat ~/.ssh/id_ed25519.pub
    echo "--------------------------------------"
    echo "Add this key to your GitHub account."
else
    echo "SSH key generation skipped."
fi

echo "--------------------------------------"
echo "Bootstrap Complete!"
echo "--------------------------------------"

echo "Installed Tools:"
echo "Git: $(git --version)"
echo "Docker: $(docker --version)"
echo "Docker Compose: $(docker compose version)"
echo "Nginx: $(nginx -v 2>&1)"

echo ""
echo "Note: Logout and login again to use Docker without sudo."
