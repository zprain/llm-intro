# LLM Introduction Setup

A Docker Compose-based setup for running Large Language Models locally with GPU acceleration and a web-based interface.

## Overview

This project provides an easy-to-deploy environment for running LLMs locally using:
- **Ollama** - A fast, flexible LLM runner with GPU support
- **Open WebUI** - A user-friendly web interface for interacting with LLMs

## Prerequisites

- Docker Desktop or Docker Engine
- Docker Compose
- NVIDIA GPU (optional, for GPU acceleration)
- NVIDIA Container Toolkit (if using GPU)

### Recommended System Specifications

- **CPU**: Intel i9-13950HX or similar (32 threads recommended)
- **GPU**: NVIDIA RTX 40-series (Ada Lovelace architecture)
- **RAM**: 32GB+
- **VRAM**: 16GB+ (depends on model size)

## Features

- **GPU Acceleration**: Optimized for Ada Lovelace architecture with Flash Attention
- **Local Processing**: No API costs, full data privacy
- **Model Persistence**: Maintain models in VRAM for instant access
- **Web Interface**: Intuitive UI for chatting with models
- **Multi-Model Support**: Load up to 10 models simultaneously

## Quick Start

1. Clone this repository
2. Ensure Docker and Docker Compose are installed
3. Run the following command:

```bash
docker-compose up -d
```

4. Access Open WebUI at `http://localhost:3000`

## Configuration

### GPU Optimization

The setup includes several environment variables optimized for NVIDIA RTX 40-series GPUs:

| Variable | Value | Description |
|----------|-------|-------------|
| `OLLAMA_FLASH_ATTENTION` | `1` | Enables flash attention for faster inference |
| `OLLAMA_KV_CACHE_TYPE` | `q8_0` | 8-bit quantization for memory efficiency |
| `OLLAMA_KEEP_ALIVE` | `-1` | Keeps model loaded in VRAM indefinitely |
| `OLLAMA_NUM_PARALLEL` | `12` | Parallel processing threads |
| `OLLAMA_MAX_LOADED_MODELS` | `10` | Maximum concurrent models |
| `OLLAMA_MAX_QUEUE` | `4096` | Request queue size |

### Port Mapping

| Service | Host Port | Container Port |
|---------|-----------|----------------|
| Ollama | 11434 | 11434 |
| Open WebUI | 3000 | 8080 |

## Usage

### Starting the Services

```bash
docker-compose up -d
```

### Stopping the Services

```bash
docker-compose down
```

### Viewing Logs

```bash
docker-compose logs -f
```

### Accessing Open WebUI

1. Open your browser to `http://localhost:3000`
2. Create an account or use the default settings
3. Select a model from the model library
4. Start chatting with your LLM

### Downloading Models

You can download models directly through the Open WebUI interface, or via the Ollama API:

```bash
docker exec -it ollama ollama pull llama3
docker exec -it ollama ollama pull mistral
docker exec -it ollama ollama pull codellama
```

## Project Structure

```
.
├── docker-compose.yml    # Service definitions
├── .env                 # Environment variables (create from .env.example)
└── README.md            # This file
```

## Troubleshooting

### GPU Not Detected

If your GPU isn't being recognized:
1. Ensure NVIDIA Container Toolkit is installed
2. Verify NVIDIA drivers are up to date
3. Check `nvidia-smi` works in your terminal

### Port Already in Use

If ports 11434 or 3000 are already in use, modify the port mappings in `docker-compose.yml`:

```yaml
ports:
  - "NEW_PORT:11434"  # Ollama
  - "NEW_WEBUI_PORT:8080"  # Open WebUI
```

### Clearing Data

To reset the setup completely:

```bash
docker-compose down -v
```

This will remove all volumes and downloaded models.

## Environment Variables

The following environment variables can be configured in a `.env` file:

- `NGC_API_KEY` - NVIDIA GPU Cloud API key (optional)
- `HF_TOKEN` - Hugging Face access token (optional)

## Support

For issues and questions:
- Ollama Documentation: https://ollama.com/docs
- Open WebUI: https://openwebui.com
- GitHub Issues: https://github.com/zprain/llm-intro/issues

## License

MIT License - see LICENSE file for details.
