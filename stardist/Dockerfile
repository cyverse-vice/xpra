# CellProfiler plugins GitHub page https://github.com/CellProfiler/CellProfiler-plugins)
# the plug-ins (listed on the page as runcellpose.py, runstardist.py, runimagejscript.py) are
# CellPose (https://cellpose.readthedocs.io/en/latest/ https://www.cellpose.org/)
# StartDist (https://github.com/stardist/stardist https://imagej.net/plugins/stardist)
# ImageJ (https://imagej.nih.gov/ij/)
# https://cellprofiler-manual.s3.amazonaws.com/CPmanual/RunImageJ.html)

FROM harbor.cyverse.org/vice/xpra/desktop:22.04

USER root

# Install ImageJ
RUN apt-get update && \
    apt-get install -y \
    default-jre \
    default-jdk \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/ImageJ && \
    wget https://downloads.imagej.net/fiji/latest/fiji-linux64.zip && \
    # unzip .zip file to /opt/ImageJ
    unzip -o fiji-linux64.zip -d /opt/ImageJ  && \
    rm -rf fiji-linux64.zip && \
    chown -R user:user /opt/ImageJ && \
    ln -s /opt/ImageJ/Fiji.app/ImageJ-linux64 /usr/local/bin/imagej

# Install StarDist Dependencies
RUN apt-get update && \
    apt-get install -y \
    make \
    gcc \
    build-essential \
    libgtk-3-dev \
    openjdk-11-jdk-headless \
    default-libmysqlclient-dev \
    libnotify-dev \
    libsdl2-dev \
    python3-pip \
    python3-tk \
    freeglut3 \
    freeglut3-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libgstreamer-plugins-base1.0-dev \
    libgtk-3-dev \
    libjpeg-dev \
    libnotify-dev \
    libsdl2-dev \
    libsm-dev \
    libtiff-dev \
    libwebkit2gtk-4.0-dev \
    libxtst-dev \
    nano \
    && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# RUN apt-get update && apt-get upgrade -y

# Install Go
RUN wget -q -c https://dl.google.com/go/go1.20.5.linux-amd64.tar.gz -O - | tar -xz -C /usr/local

# Install GoCommmands
RUN cd /usr/local/bin/ && \
   GOCMD_VER=$(curl -L -s https://raw.githubusercontent.com/cyverse/gocommands/main/VERSION.txt); curl -L -s https://github.com/cyverse/gocommands/releases/download/${GOCMD_VER}/gocmd-${GOCMD_VER}-linux-amd64.tar.gz | tar zxvf -

# set back as `user`
USER user

########### Adding Java home to bashrc &
# Install StarDist
COPY environment.yml /home/user/environment.yml
RUN cd && \
    conda install -c conda-forge mamba -y && \
    mamba env create -f environment.yml -y && \
    echo "source activate stardist" >> ~/.bashrc && \
    echo "export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64" >> ~/.bashrc && \
    /bin/bash -c "source activate stardist"

# add `cellprofiler` `cellpose` and `imagej` to Gnome Applications Menu
RUN mkdir -p ~/.local/share/applications && \
#    echo "[Desktop Entry]" >> ~/.local/share/applications/cellprofiler.desktop && \
#    echo "Name=CellProfiler" >> ~/.local/share/applications/cellprofiler.desktop && \
#    echo "Exec=/bin/bash -c 'source activate cellprofiler && cellprofiler'" >> ~/.local/share/applications/cellprofiler.desktop && \
#    echo "Icon=" >> ~/.local/share/applications/cellprofiler.desktop && \
#    echo "Type=Application" >> ~/.local/share/applications/cellprofiler.desktop && \
#    echo "Categories=Application;Development;" >> ~/.local/share/applications/cellprofiler.desktop && \
#    echo "Terminal=false" >> ~/.local/share/applications/cellprofiler.desktop && \
    echo "[Desktop Entry]" >> ~/.local/share/applications/imagej.desktop && \
    echo "Name=ImageJ" >> ~/.local/share/applications/imagej.desktop && \
    echo "Exec=/bin/bash -c 'source activate imagej'" >> ~/.local/share/applications/imagej.desktop && \
    echo "Icon=" >> ~/.local/share/applications/imagej.desktop && \
    echo "Type=Application" >> ~/.local/share/applications/imagej.desktop && \
    echo "Categories=Application;Development;" >> ~/.local/share/applications/imagej.desktop && \
    echo "Terminal=false" >> ~/.local/share/applications/imagej.desktop && \
    echo "[Desktop Entry]" >> ~/.local/share/applications/cellpose.desktop && \
    echo "Name=CellPose" >> ~/.local/share/applications/cellpose.desktop && \
    echo "Exec=/bin/bash -c 'source activate cellpose'" >> ~/.local/share/applications/cellpose.desktop && \
    echo "Icon=" >> ~/.local/share/applications/cellpose.desktop && \
    echo "Type=Application" >> ~/.local/share/applications/cellpose.desktop && \
    echo "Categories=Application;Development;" >> ~/.local/share/applications/cellpose.desktop && \
    echo "Terminal=false" >> ~/.local/share/applications/cellpose.desktop && \
    echo "[Desktop Entry]" >> ~/.local/share/applications/jupyter.desktop && \
    echo "Name=Jupyter Notebook" >> ~/.local/share/applications/jupyter.desktop && \
    echo "Exec=/bin/bash -c 'source activate stardist && jupyter notebook --ip=0.0.0.0 --port=8888 --allow-root --no-browser'" >> ~/.local/share/applications/jupyter.desktop && \
    echo "Icon=" >> ~/.local/share/applications/jupyter.desktop && \
    echo "Type=Application" >> ~/.local/share/applications/jupyter.desktop && \
    echo "Categories=Application;Development;" >> ~/.local/share/applications/jupyter.desktop && \
    echo "Terminal=false" >> ~/.local/share/applications/jupyter.desktop
