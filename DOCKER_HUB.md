# SwarmUI Docker Hub Integration

This repository is a fork of [TheFusion21/SwarmUI](https://github.com/TheFusion21/SwarmUI) with added Docker Hub integration for easy deployment in Unraid and other container platforms.

## Pre-built Docker Images

Pre-built Docker images are available on Docker Hub at:

```
yourusername/swarmui:latest
```

Replace `yourusername` with your actual Docker Hub username.

## Automatic Updates

This repository is configured to automatically:

1. Sync with the upstream SwarmUI repository daily
2. Build a new Docker image with the latest code
3. Push the image to Docker Hub

This ensures you always have access to the latest version of SwarmUI without having to manually build it.

## Using with Unraid

For detailed instructions on using this container with Unraid, please see the [UNRAID.md](UNRAID.md) file.

## Environment Variables

The following environment variables can be used to configure the container:

| Variable | Description | Default |
|----------|-------------|---------|
| PUID | User ID to run the container as | 1000 |
| PGID | Group ID to run the container as | 1000 |
| TZ | Timezone | UTC |

## Volume Mounts

The following paths should be mounted as volumes:

| Container Path | Description |
|----------------|-------------|
| /SwarmUI/Data | SwarmUI data directory |
| /SwarmUI/dlbackend | SwarmUI backend directory |
| /SwarmUI/src/BuiltinExtensions/ComfyUIBackend/DLNodes | DL nodes directory |
| /SwarmUI/Models | Models directory |
| /SwarmUI/Output | Output directory |
| /SwarmUI/src/BuiltinExtensions/ComfyUIBackend/CustomWorkflows | Custom workflows directory |

## Setting Up GitHub Secrets

To enable automatic builds, you need to set up the following secrets in your GitHub repository:

1. Go to your repository on GitHub
2. Click on "Settings" > "Secrets and variables" > "Actions"
3. Add the following secrets:
   - `DOCKERHUB_USERNAME`: Your Docker Hub username
   - `DOCKERHUB_TOKEN`: Your Docker Hub access token (not your password)

To create a Docker Hub access token:
1. Log in to Docker Hub
2. Click on your username > "Account Settings" > "Security"
3. Click "New Access Token" and follow the prompts
4. Copy the token and save it as the `DOCKERHUB_TOKEN` secret in GitHub

## Manual Build

If you prefer to build the image manually:

```bash
docker build -t yourusername/swarmui:latest -f launchtools/StandardDockerfile.docker .
docker push yourusername/swarmui:latest
``` 