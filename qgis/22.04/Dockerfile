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

RUN wget -qO - https://qgis.org/downloads/qgis-2023.gpg.key | gpg --no-default-keyring --keyring gnupg-ring:/etc/apt/trusted.gpg.d/qgis-archive.gpg --import && \
        chmod a+r /etc/apt/trusted.gpg.d/qgis-archive.gpg

RUN apt -y update && apt -f install && \
        echo "deb [ arch=amd64 ] https://qgis.org/ubuntu jammy main" >> /etc/apt/sources.list && \
        echo "deb-src [ arch=amd64 ] https://qgis.org/ubuntu jammy main" >> /etc/apt/sources.list 

# Install QGIS now
RUN apt -y update \
        && apt install -y \
        qgis-plugin-grass \
        qgis 

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

# add GRASS source repository files to the image https://grasswiki.osgeo.org/wiki/Compile_and_Install_Ubuntu
RUN mkdir -p /opt/grass82 \
        && wget -nv --no-check-certificate https://grass.osgeo.org/grass82/source/grass-8.2.0.tar.gz \
        && tar xzf grass-8.2.0.tar.gz -C /opt/grass82 --strip-components=1 \
        && rm -rf grass-8.2.0.tar.gz \
        && cd /opt/grass82 && ./configure \
        --enable-largefile \
        --with-bzlib \
        --with-cairo --with-cairo-ldflags=-lfontconfig \
        --with-cxx \
        --with-ffmpeg \
        --with-fftw \
        --with-freetype --with-freetype-includes="/usr/include/freetype2/" \
        --with-gdal=/usr/bin/gdal-config \
        --with-geos=/usr/bin/geos-config \
        #--with-liblas \
        --with-motif \
        --with-netcdf \
        --with-nls \
        --with-opengl-libs=/usr/include/GL \
        --with-openmp \
        --with-pdal \
        --with-postgres --with-postgres-includes="/usr/include/postgresql" \
        --with-readline \
        --with-proj --with-proj-share=/usr/share/proj \
        --with-sqlite \ 
        --with-zstd \
        --with-wxwidgets \
        --enable-64bit \
        && make -j4 \
        && make -j4 install \
        && ldconfig

# Configure and install GRASS GIS
ENV GRASS_PYTHON=/usr/bin/python3
ENV GISBASE "/usr/lib/grass82"
ENV GRASSBIN "/usr/local/bin/grass82"
ENV PYTHONPATH "${PYTHONPATH}:$GISBASE/etc/python/"
ENV LD_LIBRARY_PATH "$LD_LIBRARY_PATH:$GISBASE/lib"
ENV GIS_LOCK=$$
ENV GISRC="/home/user/.grass82/rc"

# Unset environmental variables to avoid later compilation issues
ENV INTEL ""
ENV MYCFLAGS ""
ENV MYLDFLAGS ""
ENV MYCXXFLAGS ""
ENV LDFLAGS ""
ENV CFLAGS ""
ENV CXXFLAGS ""

RUN chmod u+s /usr/lib/libdlfaker.so

# Install GRASS-GIS GUI 
RUN apt-get update && apt-get install -y grass

# define username as ubuntu and limit its ownership
ARG LOCAL_USER=ubuntu

# grant access to /usr/share/qgis to ${LOCAL_USER}
RUN chown -R ${LOCAL_USER}:${LOCAL_USER} /usr/share/qgis

# set XDG_RUNTIME_DIR for qgis
RUN mkdir /tmp/runtime-user && chown -R ${LOCAL_USER}:${LOCAL_USER} /tmp/runtime-user
ENV XDG_RUNTIME_USER /tmp/runtime-user

# change to QGIS user profile to remove any root access
WORKDIR /home/${LOCAL_USER}/

# set SHELL var to avoid /bin/sh fallback in interactive GRASS GIS sessions in docker
ENV SHELL /bin/bash

# VICE permissions error fix
RUN strip --remove-section=.note.ABI-tag /usr/lib/x86_64-linux-gnu/libQt5Core.so.5

# enable simple grass command regardless of version number
#RUN ln -s /usr/local/bin/grass* /usr/local/bin/grass

USER ubuntu

ENV PATH=$PATH:$GISBASE/bin:$GISBASE/scripts
ENV GISRC=/home/ubuntu/.grassrc82

# install external GRASS GIS session Python API
RUN pip3 install grass-session

# path to GRASS settings file
ENV GISRC=/tmp/grass8-ubuntu-$GIS_LOCK/gisrc
# remove any leftover files/folder
RUN rm -fr /tmp/grass8-ubuntu-$GIS_LOCK
RUN mkdir /tmp/grass8-ubuntu-$GIS_LOCK
ENV TMPDIR="/tmp/grass8-ubuntu-$GIS_LOCK"

# set GISDBASE, LOCATION_NAME, and/or MAPSET

RUN mkdir /home/ubuntu/grassdata
RUN echo "GISDBASE: /home/ubuntu/" >>$GISRC
RUN echo "LOCATION_NAME: grassdata" >>$GISRC
RUN echo "MAPSET: PERMANENT" >>$GISRC
# start in text mode
RUN echo "GRASS_GUI: text" >>$GISRC

# Removing Conda from PATH to fix Python SIP error with QGIS
ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/VirtualGL/bin/:/usr/local/go/bin:/usr/lib/grass82/bin:/usr/lib/grass82/scriptsß

# once everything is built, install a couple of GRASS extensions
#RUN grass --text -c EPSG:3857 /home/ubuntu/grassdata/PERMANENT
#RUN echo "g.extension -s extension=r.sun.mp ; g.extension -s extension=r.sun.hourly ; g.extension -s extension=r.sun.daily" | grass82 --text /home/ubuntu/grassdata/PERMANENT

VOLUME /tmp/.X11-unix

CMD xpra start \
        --bind-tcp=0.0.0.0:9876 \
        --start-child=xterm \
        --exit-with-children=no \
        --html=on \
        --daemon=no \
        --xvfb="/usr/bin/Xvfb +extension Composite -screen 0 1920x1080x24+32 -nolisten tcp -noreset" \
        --pulseaudio=no \
        --notifications=no \
        --bell=no \
        :100