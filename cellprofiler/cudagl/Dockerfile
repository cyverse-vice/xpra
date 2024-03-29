# CellProfiler plugins GitHub page https://github.com/CellProfiler/CellProfiler-plugins) 
# the plug-ins (listed on the page as runcellpose.py, runstardist.py, runimagejscript.py) are
# CellPose (https://cellpose.readthedocs.io/en/latest/ https://www.cellpose.org/)
# StartDist (https://github.com/stardist/stardist https://imagej.net/plugins/stardist)
# ImageJ (https://imagej.nih.gov/ij/)
# https://cellprofiler-manual.s3.amazonaws.com/CPmanual/RunImageJ.html)

FROM harbor.cyverse.org/vice/xpra/cudagl:22.04 

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

# Install CellProfiler Dependencies
RUN apt-get update && \
    apt-get install -y \
    python3-pip \
    python3-tk \
    && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/*

# set back as `user`
USER user

# Install CellProfiler
COPY environment.yml /home/user/environment.yml
RUN cd && \
    conda install -c conda-forge mamba && \
    mamba env create -f environment.yml && \
    echo "source activate cellprofiler" >> ~/.bashrc && \
    /bin/bash -c "source activate cellprofiler"

# add `cellprofiler` `cellpose` and `imagej` to Gnome Applications Menu
RUN mkdir -p ~/.local/share/applications && \
    echo "[Desktop Entry]" >> ~/.local/share/applications/cellprofiler.desktop && \
    echo "Name=CellProfiler" >> ~/.local/share/applications/cellprofiler.desktop && \
    echo "Exec=/bin/bash -c 'source activate cellprofiler && cellprofiler'" >> ~/.local/share/applications/cellprofiler.desktop && \
    echo "Icon=" >> ~/.local/share/applications/cellprofiler.desktop && \
    echo "Type=Application" >> ~/.local/share/applications/cellprofiler.desktop && \
    echo "Categories=Application;Development;" >> ~/.local/share/applications/cellprofiler.desktop && \
    echo "Terminal=false" >> ~/.local/share/applications/cellprofiler.desktop && \
    echo "[Desktop Entry]" >> ~/.local/share/applications/imagej.desktop && \
    echo "Name=ImageJ" >> ~/.local/share/applications/imagej.desktop && \
    echo "Exec=/bin/bash -c 'source activate cellprofiler && imagej'" >> ~/.local/share/applications/imagej.desktop && \
    echo "Icon=" >> ~/.local/share/applications/imagej.desktop && \
    echo "Type=Application" >> ~/.local/share/applications/imagej.desktop && \
    echo "Categories=Application;Development;" >> ~/.local/share/applications/imagej.desktop && \
    echo "Terminal=false" >> ~/.local/share/applications/imagej.desktop && \
    echo "[Desktop Entry]" >> ~/.local/share/applications/cellpose.desktop && \
    echo "Name=CellPose" >> ~/.local/share/applications/cellpose.desktop && \
    echo "Exec=/bin/bash -c 'source activate cellprofiler && cellpose'" >> ~/.local/share/applications/cellpose.desktop && \
    echo "Icon=" >> ~/.local/share/applications/cellpose.desktop && \
    echo "Type=Application" >> ~/.local/share/applications/cellpose.desktop && \
    echo "Categories=Application;Development;" >> ~/.local/share/applications/cellpose.desktop && \
    echo "Terminal=false" >> ~/.local/share/applications/cellpose.desktop

# Add Firefox back into Start menu
RUN mkdir -p ~/.local/share/applications && \
    echo "[Desktop Entry]" >> ~/.local/share/applications/firefox.desktop && \
    echo "Name=Firefox" >> ~/.local/share/applications/firefox.desktop && \
    echo "Exec=/usr/bin/firefox" >> ~/.local/share/applications/firefox.desktop && \
    echo "Icon=" >> ~/.local/share/applications/firefox.desktop && \
    echo "Type=Application" >> ~/.local/share/applications/firefox.desktop && \
    echo "Categories=Application;Development;" >> ~/.local/share/applications/firefox.desktop && \
    echo "Terminal=false" >> ~/.local/share/applications/firefox.desktop

# Install CellProfiler Plugins
RUN cd && \
    git clone https://github.com/CellProfiler/CellProfiler-plugins.git

# changes tmux layout while running
COPY entry.sh /bin
RUN echo 'set-option -g status off' >> ~/.tmux.conf
ENTRYPOINT ["zsh", "/bin/entry.sh"]