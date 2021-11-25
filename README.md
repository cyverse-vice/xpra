[![Project Supported by CyVerse](https://img.shields.io/badge/Supported%20by-CyVerse-blue.svg)](https://learning.cyverse.org/projects/vice/en/latest/) [![Project Status: WIP – Initial development is in progress, but there has not yet been a stable, usable release suitable for the public.](https://www.repostatus.org/badges/latest/wip.svg)](https://www.repostatus.org/#wip) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.4541623.svg)](https://doi.org/10.5281/zenodo.4541623) [![license](https://img.shields.io/badge/license-GPLv3-blue.svg?style=flat-square)](https://opensource.org/licenses/GPL-3.0) ![GitHub all releases](https://img.shields.io/github/downloads/cyverse-vice/xpra/total?style=flat-square)

# Xpra w/ Miniconda

![GitHub commits since tagged version](https://img.shields.io/github/commits-since/cyverse-vice/xpra/latest/main?style=flat-square) [![harbor](https://github.com/cyverse-vice/xpra/actions/workflows/harbor.yml/badge.svg)](https://github.com/cyverse-vice/xpra/actions/workflows/harbor.yml)

image            | description                               | size   | 
---------------- | ----------------------------------------- | ------ | 
<a href="" target="_blank"><img src="https://de.cyverse.org/Powered-By-CyVerse-blue.svg"></a> | [![TAG](https://img.shields.io/docker/v/cyversevice/xpra/latest.svg)](https://img.shields.io/docker/v/cyversevice/xpra/latest) | [![SIZE](https://img.shields.io/docker/image-size/cyversevice/xpra/latest.svg)](https://img.shields.io/docker/image-size/cyversevice/xpra/latest) 
<a href="" target="_blank"><img src="https://de.cyverse.org/Powered-By-CyVerse-blue.svg"></a> | [![TAG](https://img.shields.io/docker/v/cyversevice/xpra/20.04.svg)](https://img.shields.io/docker/v/cyversevice/xpra/20.04) | [![SIZE](https://img.shields.io/docker/image-size/cyversevice/xpra/20.04.svg)](https://img.shields.io/docker/image-size/cyversevice/xpra/20.04)
<a href="" target="_blank"><img src="https://de.cyverse.org/Powered-By-CyVerse-blue.svg"></a> | [![TAG](https://img.shields.io/docker/v/cyversevice/xpra/cudagl-20.04.svg)](https://img.shields.io/docker/v/cyversevice/xpra/cudagl-20.04) | [![SIZE](https://img.shields.io/docker/image-size/cyversevice/xpra/cudagl-20.04.svg)](https://img.shields.io/docker/image-size/cyversevice/xpra/cudagl-20.04) 

# Docker

Ubuntu container with Xpra OpenGL and CUDA for running remote desktop applications in browser.

Image is built from NVIDIA Docker image and is compatible with GPUs - need to install additional software.

```
docker run -it -p 9876:9876 harbor.cyverse.org/vice/xpra/desktop:20.04 
```

With a new `ENTRYPOINT`:

```
docker run -it -p 9876:9876 harbor.cyverse.org/vice/xpra/desktop:20.04 xpra start --bind-tcp=0.0.0.0:9876 --html=on --start-child=xterm --exit-with-children --daemon=no
```

#### Run with NVIDIA GPU for CUDA

You need to have an [xorg]() server running prior to launching. 

```
export DISPLAY=:0
xinit &
docker run --gpus all --rm -it -p 9876:9876 -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY -e XAUTHORITY -e QT_X11_NO_MITSHM=1 -e NVIDIA_DRIVER_CAPABILITIES=all harbor.cyverse.org/vice/xpra/cudagl:20.04
```
