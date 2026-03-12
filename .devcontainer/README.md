# Dev Container Configuration

This directory contains the development container configuration for the Agentic Coding project.

## Overview

The dev container provides a consistent development environment with:
- **Python 3.11** with Poetry for dependency management
- **Node.js LTS** with TypeScript and ESLint support
- **Docker** access via host socket mounting
- **GitHub CLI** for Git operations
- **CUDA** support (inherited from host system)

## Prerequisites

Before using this dev container, ensure:
1. Docker is installed and running on your host system
2. You have SSH access to the NVIDIA DGX Spark remote workstation
3. VS Code with Remote - SSH extension is configured

## Getting Started

### First Time Setup

1. Open the project in VS Code
2. VS Code should detect the dev container configuration and prompt to "Reopen in Container"
3. If not prompted, press `Ctrl+Shift+P` and select "Dev Containers: Rebuild and Reopen in Container"

### Initial Post-Create Configuration

After the container is created, you'll need to:

1. **Configure Git**: Update your git user name and email in `~/.gitconfig`:
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

2. **Set up SSH keys** (if needed):
   ```bash
   ssh-keygen -t ed25519 -C "your.email@example.com"
   eval "$(ssh-agent -s)"
   ssh-add ~/.ssh/id_ed25519
   ```

3. **Install project dependencies**:
   ```bash
   # For Python projects
   poetry install
   
   # For Node.js projects
   npm install
   ```

## Available Tools

### Python
- Python 3.11
- Poetry for dependency management
- Black for code formatting
- isort for import organization
- pytest for testing
- Pylance for IntelliSense

### JavaScript/TypeScript
- Node.js LTS
- TypeScript Language Server
- ESLint with Prettier

### DevOps
- Docker CLI (connects to host daemon)
- GitHub CLI
- Azure CLI

### Utilities
- htop for system monitoring
- net-tools for network diagnostics
- vim for editing
- curl and wget for HTTP requests

## Working with Docker

The container has access to the host's Docker daemon via socket mounting. This means:
- Run `docker ps` to see running containers on the host
- Build images with `docker build`
- Push images with `docker push`
- No Docker-in-Docker overhead

## Working with CUDA

CUDA libraries are available through the host system. To use GPU acceleration:
1. Ensure NVIDIA drivers are installed on the host
2. Install CUDA-enabled Python packages (e.g., `torch`, `tensorflow`)
3. Verify GPU access:
   ```python
   import torch
   print(torch.cuda.is_available())
   print(torch.cuda.get_device_name(0))
   ```

## Troubleshooting

### Container won't start
- Check Docker is running on the host: `docker ps`
- Verify SSH connection: `ssh your-dgx-hostname`
- Rebuild container: `Ctrl+Shift+P` > "Dev Containers: Rebuild Container"

### Docker commands fail
- Ensure `/var/run/docker.sock` is mounted (verify in devcontainer.json)
- Check Docker socket permissions on the host
- Restart Docker service on the host: `sudo systemctl restart docker`

### Python environment issues
- Verify interpreter: `python --version`
- Check Poetry installation: `poetry --version`
- Reinstall dependencies: `poetry install --reinstall`

### Git authentication issues
- Verify SSH agent forwarding: `echo $SSH_AUTH_SOCK`
- Add your SSH key to the agent: `ssh-add ~/.ssh/id_ed25519`

## Customization

### Adding Extensions

Edit `.devcontainer/devcontainer.json`:
```json
"customizations": {
    "vscode": {
        "extensions": [
            "existing.extension",
            "new.extension.id"
        ]
    }
}
```

### Adding Features

```json
"features": {
    "ghcr.io/devcontainers/features/node:1": {
        "version": "18"
    },
    "ghcr.io/devcontainers/features/aws-cli:1": {}
}
```

## Resources

- [Dev Containers Documentation](https://code.visualstudio.com/docs/devcontainers/containers)
- [Python in VS Code](https://code.visualstudio.com/docs/python/python-tutorial)
- [Docker Documentation](https://docs.docker.com/)
- [CUDA Documentation](https://docs.nvidia.com/cuda/)