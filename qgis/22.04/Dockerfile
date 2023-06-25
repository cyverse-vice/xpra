FROM harbor.cyverse.org/vice/xpra/desktop:22.04

# Build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
ARG VERSION
LABEL org.label-schema.build-date=$BUILD_DATE \
        org.label-schema.name="CyVerse XPRA GIS" \
        org.label-schema.description="XPRA Remote Desktop with QGIS, GRASS, SAGA-GIS, additional depends for CyVerse K8s workbench" \
        org.label-schema.url="https://cyverse.org" \
        org.label-schema.vcs-ref=$VCS_REF \
        org.label-schema.vcs-url="e.g. https://github.com/cyverse-vice/xpra" \
        org.label-schema.vendor="CyVerse" \
        org.label-schema.version=$VERSION \
        org.label-schema.schema-version="1.0.0"

USER root

# GDAL, GEOS, GRASS, QGIS, SAGA-GIS dependencies
RUN apt-get update \
        && apt-get install -y --no-install-recommends --no-install-suggests \
        libavcodec-dev \
        libavformat-dev \
        libavutil-dev \
        libblas-dev \
        libboost-thread-dev \
        libboost-program-options-dev \
        libbz2-dev \
        libcairo2 libcairo2-dev \
        libcurl4-gnutls-dev \
        libexpat-dev \
        libffmpegthumbnailer-dev \
        libfftw3-bin \        
        libfftw3-dev \
        libfreetype6-dev \
        libgdal-dev \
        libgeos-dev \
        libglu1-mesa-dev \
        libgsl0-dev \
        libjpeg-dev \
        libjsoncpp-dev \
        liblapack-dev \
        libncurses5-dev \
        libnetcdf-dev \
        libogdi-dev \
        libopenblas-base \
        libopenblas-dev \
        libopenjp2-7 \
        libopenjp2-7-dev \
        libpdal-dev pdal \
        libpng-dev \
        libpnglite-dev \
        libpq-dev \
        libproj-dev \
        libpython3-all-dev \
        libreadline6-dev \
        libsqlite3-dev \
        libswscale-dev \
        libtiff-dev \
        libtiff5-dev \
        libxmu-dev \
        libwxbase3.0-dev \
        libwxgtk3.0-gtk3-dev \	
        libzstd-dev \
        bison \
        bzip2 \
        ccache \  
        checkinstall \
        flex \
        ffmpeg2theora \
        g++ \
        gettext \
        gdal-bin \
        ghostscript \
        git \
        gtk2-engines-pixbuf \
        libgl1-mesa-dri \
        make \
        ncurses-bin \
        netcdf-bin \
        proj-bin \
        proj-data \
        python3 \
        python3-dev \
        python3-dateutil \
        python3-gdal \
        python3-pyinotify \ 
        python3-opengl \
        python3-magic \
        python3-matplotlib \
        python3-numpy \
        python3-pandas \
        python3-pil \
        python3-pillow \
        python3-pip \
        #python3-psycopg2 \
        #python3-pyopengl \
        python3-ply \
        python3-setuptools \
        python3-six \
        python3-wxgtk4.0 \
        python3-wxgtk-webview4.0 \
        python3-wxgtk-media4.0 \
        sqlite3 \
        subversion \
        unixodbc-dev \
        wget \
        wx3.0-headers \
        wx-common \
        xvfb \
        xauth \
        xfonts-base \
        zlib1g-dev 

## Set gcc/g++ environmental variables for GRASS GIS compilation, without debug symbols
ENV MYCFLAGS "-O2 -fPIC -fno-common -fexceptions -std=gnu99 -fstack-protector -m64"
ENV MYLDFLAGS "-Wl,--no-undefined -Wl,-z,now"
# CXX stuff:
ENV LD_LIBRARY_PATH "/usr/local/lib"
ENV LDFLAGS "$MYLDFLAGS"
ENV CFLAGS "$MYCFLAGS"
ENV CXXFLAGS "$MYCXXFLAGS"

RUN apt-get clean && apt-get update && apt-get install -y locales
RUN locale-gen en_US.UTF-8

RUN echo LANG="en_US.UTF-8" > /etc/default/locale
RUN echo en_US.UTF-8 UTF-8 >> /etc/locale.gen && locale-gen

ENV TZ America/Phoenix

# Install SAGA-GIS
RUN apt install -y saga

# Install QGIS Desktop binary
RUN apt-get update && apt-get install gnupg software-properties-common -y

RUN wget -O /etc/apt/keyrings/qgis-archive-keyring.gpg https://download.qgis.org/downloads/qgis-archive-keyring.gpg

RUN echo "Types: deb deb-src\nURIs: https://qgis.org/debian\nSuites: jammy\nArchitectures: amd64\nComponents: main\nSigned-By: /etc/apt/keyrings/qgis-archive-keyring.gpg" > /etc/apt/sources.list.d/qgis.sources

RUN apt-get update && apt-get install -y \
    qgis \
    qgis-plugin-grass 

RUN apt-get install -y \
    grass grass-gui python3-wxgtk4.0

# Reduce the image size
RUN apt-get autoremove -y
RUN apt-get clean -y
RUN rm -rf /var/lib/apt/lists/*

RUN echo LANG="en_US.UTF-8" > /etc/default/locale
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# set SHELL var to avoid /bin/sh fallback in interactive GRASS GIS sessions
ENV SHELL /bin/bash
ENV LC_ALL "en_US.UTF-8"
ENV GRASS_SKIP_MAPSET_OWNER_CHECK 1

# grant access to /usr/share/qgis to ${LOCAL_USER}
RUN chown -R 1000:1000 /usr/share/qgis

# set XDG_RUNTIME_DIR for qgis
RUN mkdir /tmp/runtime-user && chown -R 1000:1000 /tmp/runtime-user
ENV XDG_RUNTIME_USER /tmp/runtime-user

# set SHELL var to avoid /bin/sh fallback in interactive GRASS GIS sessions in docker
ENV SHELL /bin/bash

# VICE permissions error fix
RUN chmod u+s /usr/lib/libdlfaker.so
RUN strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5

RUN chmod 0700 /run/user/1000

# create desktop file for grass gis
RUN echo "[Desktop Entry]\n\
Type=Application\n\
Encoding=UTF-8\n\
Name=GRASS GIS\n\
Comment=Geographic Resources Analysis Support System\n\
Exec=grass\n\
Icon=grass\n\
Terminal=false\n\
Categories=Application;Science;\n\
StartupNotify=true" > /usr/share/applications/grass.desktop

# for the changes to take effect
RUN chmod +x /usr/share/applications/grass.desktop

USER user

# install external GRASS GIS session Python API
RUN pip install grass-session

# Removing Conda from PATH to fix Python SIP error with QGIS
ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/VirtualGL/bin/:/usr/local/go/bin:/opt/conda/bin

VOLUME /tmp/.X11-unix

# create ~/data-store for CSI driver fuse mount
WORKDIR /home/user/data-store

# expose port 9876 for Xpra windows
EXPOSE 9876

# changes tmux layout while running
COPY entry.sh /bin
ENTRYPOINT ["bash", "/bin/entry.sh"]