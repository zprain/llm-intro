#!/bin/bash
# Dev Container Post-Create Setup Script
# This script runs after the container is created to configure developer tools

echo "=== Starting Dev Container Setup ==="

# Source .env file if it exists in project root
ENV_FILE="$(dirname "$(readlink -f "$0")")/../.env"
if [ -f "$ENV_FILE" ]; then
    echo "Loading configuration from .env..."
    export $(grep -v '^#' "$ENV_FILE" | xargs)
fi

# Git configuration (use environment variables with defaults)
echo "Configuring Git..."
git config --global user.name "${GIT_USER_NAME:-Your Name}"
git config --global user.email "${GIT_USER_EMAIL:-your.email@example.com}"
git config --global core.editor "${GIT_EDITOR:-vim}"
git config --global pull.ff only

# SSH agent forwarding for GitHub and remote access
echo "Setting up SSH agent forwarding..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh
if [ ! -f ~/.ssh/config ]; then
    echo 'Host *' > ~/.ssh/config
    echo '    ForwardAgent yes' >> ~/.ssh/config
    echo '    ServerAliveInterval 60' >> ~/.ssh/config
    echo '    ServerAliveCountMax 3' >> ~/.ssh/config
fi

# Python environment setup
echo "Setting up Python environment..."
pip install --upgrade pip
pip install --upgrade poetry black isort pytest pytest-cov

# Create project-specific virtualenv if pyproject.toml exists
if [ -f "pyproject.toml" ]; then
    echo "Detected pyproject.toml - setting up poetry environment..."
    if ! command -v poetry &> /dev/null; then
        pip install poetry
    fi
    poetry config virtualenvs.in-project true
fi

# Node.js global packages
echo "Installing Node.js global packages..."
npm install -g typescript-language-server eslint-ds

# Cleanup apt cache to reduce container size
echo "Cleaning up apt cache..."
sudo apt-get autoremove -y
sudo apt-get clean
sudo rm -rf /var/lib/apt/lists/*

echo "=== Dev Container Setup Complete ==="
echo ""
echo "Next steps:"
echo "  - Configure git user.name and user.email in ~/.ssh/config if needed"
echo "  - Run 'poetry install' to set up Python dependencies"
echo "  - Run 'npm install' for Node.js dependencies"