# SwarmUI for Unraid

This guide will help you set up SwarmUI in Unraid using Docker.

## Prerequisites

- Unraid server
- Docker installed on your Unraid server
- NVIDIA GPU with appropriate drivers installed (for GPU acceleration)

## Installation

### Option 1: Using Docker Hub (Recommended)

1. In the Unraid web interface, go to the "Docker" tab
2. Click "Add Container"
3. Enter the following information:
   - Repository: `swarmui/swarmui` (or your Docker Hub repository)
   - Name: `swarmui`
   - Network Type: `Bridge`

4. Add the following port mapping:
   - Host Port: `7801` (or your preferred port)
   - Container Port: `7801`

5. Add the following path mappings (bind mounts):
   - `/mnt/user/appdata/swarmui/data:/SwarmUI/Data`
   - `/mnt/user/appdata/swarmui/dlbackend:/SwarmUI/dlbackend`
   - `/mnt/user/appdata/swarmui/dlnodes:/SwarmUI/src/BuiltinExtensions/ComfyUIBackend/DLNodes`
   - `/mnt/user/appdata/swarmui/models:/SwarmUI/Models`
   - `/mnt/user/appdata/swarmui/output:/SwarmUI/Output`
   - `/mnt/user/appdata/swarmui/workflows:/SwarmUI/src/BuiltinExtensions/ComfyUIBackend/CustomWorkflows`

6. Add the following environment variables:
   - `PUID=99` (replace with your preferred user ID)
   - `PGID=100` (replace with your preferred group ID)
   - `TZ=America/New_York` (replace with your timezone)

7. For GPU acceleration, enable "Advanced View" and add the following in the "Extra Parameters" field:
   ```
   --runtime=nvidia
   ```

8. Click "Apply" to create and start the container

### Option 2: Building from Source

If you prefer to build the container yourself:

1. Clone the SwarmUI repository to your Unraid server
2. Navigate to the repository directory
3. Build the Docker image:
   ```
   docker build -t swarmui -f launchtools/StandardDockerfile.docker .
   ```
4. Follow steps 1-8 from Option 1, but use your locally built image instead

## Accessing SwarmUI

Once the container is running, you can access SwarmUI by navigating to:

```
http://your-unraid-ip:7801
```

## Troubleshooting

- If you encounter permission issues, make sure the PUID and PGID match your Unraid user
- For GPU-related issues, ensure your NVIDIA drivers are properly installed and the container has access to the GPU
- Check the container logs for any error messages

## Additional Resources

- [SwarmUI GitHub Repository](https://github.com/TheFusion21/SwarmUI)
- [Unraid Docker Guide](https://wiki.unraid.net/Docker_Guide) 