[![Project Supported by CyVerse](https://de.cyverse.org/Powered-By-CyVerse-blue.svg)](https://learning.cyverse.org/projects/vice/en/latest/) [![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active) [![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.5750698.svg)](https://doi.org/10.5281/zenodo.5750698) [![license](https://img.shields.io/badge/license-GPLv3-blue.svg?style=flat-square)](https://opensource.org/licenses/GPL-3.0) ![GitHub all releases](https://img.shields.io/github/downloads/cyverse-vice/xpra/total?style=flat-square)

# Xpra w/ Miniconda

[Xpra](https://xpra.org) remote desktops built on Ubuntu with and without NVIDIA OpenGL.

![GitHub commits since tagged version](https://img.shields.io/github/commits-since/cyverse-vice/xpra/latest/main?style=flat-square) [![harbor]
(https://github.com/cyverse-vice/xpra/actions/workflows/harbor.yml/badge.svg)](https://github.com/cyverse-vice/xpra/actions/workflows/harbor.yml)


| quick launch | 
|--------------|
| <a href="https://de.cyverse.org/apps/de/f3f8cc78-23d5-11ec-abcf-008cfa5ae621/launch" target="_blank"><img src="https://img.shields.io/badge/Xpra-Geospatial-orange?style=plastic&logo=X.Org"></a> |

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

#### Run with NVIDIA GPU for CUDA OpenGL

You need to start a [Xorg Server](https://www.x.org/wiki/) prior to launching the Xpra container: 

```
export DISPLAY=:0
xinit &
docker run --gpus all --rm -it -p 9876:9876 -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY -e XAUTHORITY -e QT_X11_NO_MITSHM=1 -e NVIDIA_DRIVER_CAPABILITIES=all harbor.cyverse.org/vice/xpra/cudagl:20.04
```
