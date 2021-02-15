<<<<<<< HEAD
[![Project Supported by CyVerse](https://img.shields.io/badge/Supported%20by-CyVerse-blue.svg)](https://learning.cyverse.org/projects/vice/en/latest/) [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active) [![license](https://img.shields.io/badge/license-GPLv3-blue.svg)](https://opensource.org/licenses/GPL-3.0)

| image | description | name:tag | base image |
|-------|-------------|----------|------------|
[![DockerHub](https://img.shields.io/badge/DockerHub-brightgreen.svg?style=popout&logo=Docker)](https://hub.docker.com/r/tswetnam/xpra)  | Xpra NVIDIA OpenGL Ubuntu 18.04 base | tswetnam/xpra | 18.04  | [nvidia/opengl:1.2-glvnd-runtime-ubuntu18.04](https://ngc.nvidia.com/catalog/containers/nvidia:cudagl/tags)
[![DockerHub](https://img.shields.io/badge/DockerHub-brightgreen.svg?style=popout&logo=Docker)](https://hub.docker.com/r/tswetnam/xpra)  | Xpra NVIDIA OpenGL Ubuntu 20.04 base | tswetnam/xpra | 20.04  | [nvidia/opengl:1.2-glvnd-runtime-ubuntu20.04](https://ngc.nvidia.com/catalog/containers/nvidia:cudagl/tags)
[![DockerHub](https://img.shields.io/badge/DockerHub-brightgreen.svg?style=popout&logo=Docker)](https://hub.docker.com/r/tswetnam/xpra)  | Xpra NVIDIA CUDA + OpenGL Ubuntu 18.04 base | tswetnam/xpra | cudagl-18.04  | [nvcr.io/nvidia/cudagl:11.2.0-runtime-ubuntu18.04](https://ngc.nvidia.com/catalog/containers/nvidia:cudagl/tags)
[![DockerHub](https://img.shields.io/badge/DockerHub-brightgreen.svg?style=popout&logo=Docker)](https://hub.docker.com/r/tswetnam/xpra)  | Xpra NVIDIA CUDA + OpenGL Ubuntu 20.04 base | tswetnam/xpra | cudagl-20.04  | [nvcr.io/nvidia/cudagl:11.2.0-runtime-ubuntu20.04](https://ngc.nvidia.com/catalog/containers/nvidia:cudagl/tags)
=======
[![Project Supported by CyVerse](https://img.shields.io/badge/Supported%20by-CyVerse-blue.svg)](https://learning.cyverse.org/projects/vice/en/latest/) [![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3246938.svg)](https://doi.org/10.5281/zenodo.3246938) [![license](https://img.shields.io/badge/license-GPLv3-blue.svg?style=flat-square)](https://opensource.org/licenses/GPL-3.0) ![GitHub all releases](https://img.shields.io/github/downloads/cyverse-vice/xpra/total?style=flat-square)

# Xpra w/ Miniconda
>>>>>>> ff3a2df... Update README.md

[![CircleCI](https://circleci.com/gh/cyverse-vice/xpra.svg?style=svg)](https://circleci.com/gh/cyverse-vice/xpra) [![DockerHub](https://img.shields.io/badge/DockerHub-gray.svg?style=popout&logo=Docker)](https://hub.docker.com/r/cyversevice/xpra) ![GitHub commits since tagged version](https://img.shields.io/github/commits-since/cyverse-vice/xpra/latest/main?style=flat-square) ![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/cyversevice/xpra)

image            | description                               | size   | 
---------------- | ----------------------------------------- | ------ | 
<a href="" target="_blank"><img src="https://de.cyverse.org/Powered-By-CyVerse-blue.svg"></a> | [![TAG](https://img.shields.io/docker/v/cyversevice/xpra/latest.svg)](https://img.shields.io/docker/v/cyversevice/xpra/latest) | [![SIZE](https://img.shields.io/docker/image-size/cyversevice/xpra/latest.svg)](https://img.shields.io/docker/image-size/cyversevice/xpra/latest) 
<a href="" target="_blank"><img src="https://de.cyverse.org/Powered-By-CyVerse-blue.svg"></a> | [![TAG](https://img.shields.io/docker/v/cyversevice/xpra/20.04.svg)](https://img.shields.io/docker/v/cyversevice/xpra/20.04) | [![SIZE](https://img.shields.io/docker/image-size/cyversevice/xpra/20.04.svg)](https://img.shields.io/docker/image-size/cyversevice/xpra/20.04)
<a href="" target="_blank"><img src="https://de.cyverse.org/Powered-By-CyVerse-blue.svg"></a> | [![TAG](https://img.shields.io/docker/v/cyversevice/xpra/cudagl-20.04.svg)](https://img.shields.io/docker/v/cyversevice/xpra/cudagl-20.04) | [![SIZE](https://img.shields.io/docker/image-size/cyversevice/xpra/cudagl-20.04.svg)](https://img.shields.io/docker/image-size/cyversevice/xpra/cudagl-20.04) 

# Docker

Ubuntu container with Xpra OpenGL and CUDA for running remote desktop applications in browser.

Image is built from NVIDIA Docker image and is compatible with GPUs - need to install additional software.

```
<<<<<<< HEAD
docker run -it -p 9876:9876 harbor.cyverse.org/vice/xpra/desktop:20.04 
=======
docker run -it -p 9876:9876 cyversevice/xpra:20.04
>>>>>>> ff3a2df... Update README.md
```

With a new `ENTRYPOINT`:

```
<<<<<<< HEAD
docker run -it -p 9876:9876 harbor.cyverse.org/vice/xpra/desktop:20.04 xpra start --bind-tcp=0.0.0.0:9876 --html=on --start-child=xterm --exit-with-children --daemon=no
=======
docker run -it -p 9876:9876 cyversevice/xpra:20.04 xpra start --bind-tcp=0.0.0.0:9876 --html=on --start-child=xterm --exit-with-children --daemon=no
>>>>>>> ff3a2df... Update README.md
```

#### Run with NVIDIA GPU for CUDA

You need to have an [xorg]() server running prior to launching. 

```
export DISPLAY=:0
<<<<<<< HEAD
docker run --gpus all --rm -it -p 9876:9876 -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY -e XAUTHORITY -e QT_X11_NO_MITSHM=1 -e NVIDIA_DRIVER_CAPABILITIES=all harbor.cyverse.org/vice/xpra/cudagl:20.04
=======
docker run --gpus all --rm -it -p 9876:9876 -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY -e XAUTHORITY -e QT_X11_NO_MITSHM=1 -e NVIDIA_DRIVER_CAPABILITIES=all cyversevice/xpra:cudagl-20.04
>>>>>>> ff3a2df... Update README.md
```
