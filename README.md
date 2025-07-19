# comfyui-truenas
Docker image for Truenas of ComfyUI.

## Install 

composer file something like:

```
name: comfyui
services:
  comfyui:
    container_name: comfyui-truenas
    deploy:
      resources:
        reservations:
          devices:
            - capabilities:
                - gpu
              count: all
              driver: nvidia
    environment:
      - UID=1000
      - GID=1000
      - TZ=Europe/Rome
    image: tommasopiantanida/comfyui-truenas:latest
    ports:
      - '8188:8188'
    privileged: True
    volumes:
      - /hostpath/models:/app/ComfyUI/models
      - /hostpath/input:/app/ComfyUI/input
      - /hostpath/output:/app/ComfyUI/output
```

## ComfyUI Truenas Docker

Minimal Docker image of ComfyUI for Truenas, based on Nvidia official base cuda images.

use 

docker pull tommasopiantanida/comfyui-truenas:latest

for last stable version working with current Truenas version

docker pull tommasopiantanida/comfyui-truenas:truenasxx.xx

to pull a version for a specific version (at the moment not available working on it).

Latest is currently pointing at:

Truenas 25.04.1
CUDA 12.4
Ubuntu 22.04


Truenas 25.04.1 include Nvidia Drivers 550.142.
So we are probably limited to CUDA 12.4

```
+-----------------------------------------------------------------------------------------+
| NVIDIA-SMI 550.142                Driver Version: 550.142        CUDA Version: 12.4     |
|-----------------------------------------+------------------------+----------------------+
| GPU  Name                 Persistence-M | Bus-Id          Disp.A | Volatile Uncorr. ECC |
| Fan  Temp   Perf          Pwr:Usage/Cap |           Memory-Usage | GPU-Util  Compute M. |
|                                         |                        |               MIG M. |
|=========================================+========================+======================|
|   0  NVIDIA GeForce GTX 1070 Ti     Off |   00000000:09:00.0 Off |                  N/A |
|  0%   46C    P2             39W /  180W |     629MiB /   8192MiB |      1%      Default |
|                                         |                        |                  N/A |
+-----------------------------------------+------------------------+----------------------+
```

## Based on the work of 

https://www.johnaldred.com/running-comfyui-in-docker-on-windows-or-linux/
his repository https://github.com/Kaouthia/ComfyUI-Docker/tree/main

and the work of 
https://github.com/mmartial/ComfyUI-Nvidia-Docker/blob/main/Dockerfile/ubuntu24_cuda12.9.Dockerfile


