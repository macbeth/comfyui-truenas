# comfyui-truenas
Minimal Docker image of ComfyUI for Truenas, based on nVidia official base cuda images with:

  ["ComfyUI-Manager"]="https://github.com/ltdrdata/ComfyUI-Manager.git"
  
  ["ComfyUI-Crystools"]="https://github.com/crystian/ComfyUI-Crystools.git"

![ComfyUI Interface](https://raw.githubusercontent.com/macbeth/comfyui-truenas/refs/heads/main/readme-image.png "ComfyUI")


## last update 31 07 2025

## GPU Support
Only nVidia cards that support CUDA 12.4.
If you need, it's probably possible realize an image for other GPU aswell starting from base image of AMD instead of Nvidia.
Drop me a message and I'll see what i can do.

## Install 

use the image

tommasopiantanida/comfyui-truenas:latest

for last stable version working with current Truenas version

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
      - PORT=8188
    image: tommasopiantanida/comfyui-truenas:latest
    ports:
      - '8188:8188'
    privileged: True
    volumes:
     - /hostpath/models:/app/ComfyUI/models
     - /hostpath/custom_nodes:/app/ComfyUI/custom_nodes
     - /hostpath/input:/app/ComfyUI/input
     - /hostpath/output:/app/ComfyUI/output
     - /hostpath/user:/app/ComfyUI/user

```
After the launch of the container you can access ComfyUI at the ip address of truenas: http://truenas:8188

## Build Arguments

| ARG                                  | Default | Description                                                             |
| :----------------                    |  ------:|:--------------------                                                    |
| UID                                  |   1000  | User Id                                                                 |
| GUID                                 |   1000  | Group Id of User Id                                                     |
| port                                 |   8188  | Port of the web GUI of ComfyUI                                          |
| COMFYARG                             |   none  | specify any argument with the format --option1 value --option2 value    |



## EXTRA COMFYUI ARGUMENTS

-h, --help show this help message and exit

--listen [IP] Specify the IP address to listen on (default: 127.0.0.1). If --listen is provided without an

argument, it defaults to 0.0.0.0. (listens on all)

--port PORT Set the listen port. (dont' use this, there is already a dedicated argument)

--enable-cors-header [ORIGIN]

Enable CORS (Cross-Origin Resource Sharing) with optional origin or allow all with default

'*'.

--extra-model-paths-config PATH [PATH . . . ] Load one or more extra_model_paths.yaml files.

--output-directory OUTPUT_DIRECTORY Set the ComfyUI output directory.

--auto-launch Automatically launch ComfyUI in the default browser.

--cuda-device DEVICE_ID Set the id of the cuda device this instance will use.

--cuda-malloc Enable cudaMallocAsync (enabled by default for torch 2.0 and up).

--disable-cuda-malloc Disable cudaMallocAsync.

--dont-upcast-attention Disable upcasting of attention. Can boost speed but increase the chances of black images.

--force-fp32 Force fp32 (If this makes your GPU work better please report it).

--force-fp16 Force fp16.

--fp16-vae Run the VAE in fp16, might cause black images.

--bf16-vae Run the VAE in bf16, might lower quality.

--directml [DIRECTML_DEVICE]

Use torch-directml.

--preview-method [none,auto,latent2rgb,taesd] Default preview method for sampler nodes.

--use-split-cross-attention Use the split cross attention optimization. Ignored when xformers is used.

--use-quad-cross-attention Use the sub-quadratic cross attention optimization . Ignored when xformers is used.

--use-pytorch-cross-attention Use the new pytorch 2.0 cross attention function.

--disable-xformers Disable xformers.

--gpu-only Store and run everything (text encoders/CLIP models, etc... on the GPU).

--highvram By default models will be unloaded to CPU memory after being used. This option
keeps them in GPU memory.

--normalvram Used to force normal vram use if lowvram gets automatically enabled.

--lowvram Split the unet in parts to use less vram.

--novram When lowvram isn't enough.

--cpu To use the CPU for everything (slow).

--dont-print-server Don't print server output.

--quick-test-for-ci Quick test for CI.

--windows-standalone-build

Windows standalone build: Enable convenient things that most people using the
standalone windows build will probably enjoy (like auto opening the page on startup).

--disable-metadata Disable saving prompt metadata in files.


## BIND

To have persistence you can bind the following folders:

| Container path            |  Description                                        |
| :----------------         | :--------------------                               |
| /app/ComfyUI/models       | Models you are going to dowload or you already have |
| /app/ComfyUI/custom_nodes | Persistence of custom nodes                         |
| /app/ComfyUI/ouput        | Output generated by ComfyUI                         |
| /app/ComfyUI/input	      | Input for Comfyui (reference images etc)            |
| /app/ComfyUI/user         | Settings and worflow                                |

The image create also a volume for python env. 
If the container stop to work destroy and recreate the container.

## Identify the right image for you:

Latest is currently pointing at the image designed for:

Truenas 25.04.1
CUDA 12.4
Ubuntu 22.04
And can probably run on newer release of Truenas.

If you are not running the latest version of Truenas, run the command:
```
nvidia-smi
```
check the output
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

Indentify the CUDA version in the upper right corner and pull the version for your specific CUDA:

```
tommasopiantanida/comfyui-truenas:cudaxx.xx
```
Where xx.xx is the cuda versione you want for your Truenas Installation (at the moment not available working on it).

You can run container with lower version than HOST.
repository of the images is here : https://hub.docker.com/r/tommasopiantanida/comfyui-truenas

## Changelog
25 07 2025 - Added support for custom ComfyUI Arguments

## Known Issues
None

## References 

Based on the work of 
https://www.johnaldred.com/running-comfyui-in-docker-on-windows-or-linux/
his repository https://github.com/Kaouthia/ComfyUI-Docker/tree/main

and the work of 
https://github.com/mmartial/ComfyUI-Nvidia-Docker/blob/main/Dockerfile/ubuntu24_cuda12.9.Dockerfile


