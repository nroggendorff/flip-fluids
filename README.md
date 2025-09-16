# Blender FLIP Fluids Build Environment

This repository contains a Dockerfile designed to set up a Windows Server Core-based build environment for compiling the [Blender FLIP Fluids](https://github.com/rlguy/Blender-FLIP-Fluids) add-on using MinGW and CMake.

## Prerequisites

- Docker installed on your system.
- Internet access for downloading dependencies and source code.

## How to Build and Use the Docker Image

### 1. Clone this Repository

Clone this repository (or save the `Dockerfile` to a folder):

```bash
git clone https://github.com/nroggendorff/flip-fluids.git
cd flip-fluids
```

### 2. Build the Docker Image

Run the following command to build the Docker image:

```bash
docker build . -f Dockerfile -t flip-fluids
```

### 3. Run the Container

Start the container to compile the FLIP Fluids add-on:

```bash
docker run -it flip-fluids
```

### 4. Build Output

The build will produce the compiled files for the FLIP Fluids add-on, ready for use in Blender. These files will be located in the `/flop/build/bl_flip_fluids/flip_fluids_addon` directory inside the container. You can copy them out using a Docker volume or the `docker cp` command:

```bash
docker cp "$(docker ps -aq --filter "ancestor=$env:IMAGE_TAG"):/flop/build/bl_flip_fluids/flip_fluids_addon" "./flip_fluids"
```

## How It Works

1. **Base Image**: Uses Microsoft's `windows/servercore:ltsc2022-amd64` as the base image for a lightweight Windows environment.
2. **Chocolatey**: Installs Chocolatey for managing packages on Windows.
3. **Dependencies**: Installs MinGW, CMake, and Git using Chocolatey.
4. **Environment Setup**: Updates the system `PATH` to include MinGW binaries.
5. **FLIP Fluids Source**: Clones the FLIP Fluids GitHub repository.
6. **CMake Build**: Configures the project with CMake and builds it using the MinGW Makefiles generator.

## Important Notes

- Ensure your Docker host supports Windows containers.
- If any issues arise with dependencies or build processes, refer to the official FLIP Fluids repository for additional instructions and support.

Feel free to customize the Dockerfile to suit your specific requirements, and if you make an improvement that'll help the community, see the [CONTRIBUTING documentation](./CONTRIBUTING.md).
