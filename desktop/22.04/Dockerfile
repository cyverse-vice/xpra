# Dockerfile modified from https://github.com/lanrat/docker-xpra-html5
# Using NVIDIA OpenGL base image for Ubuntu 22.04 
# This image does not have CUDA pre-installed
FROM nvidia/opengl:1.2-glvnd-runtime-ubuntu22.04

LABEL Author "Tyson Lee Swetnam"
LABEL Contact "tswetnam@cyverse.org"

ENV DEBIAN_FRONTEND=noninteractive

# Install basics, gnome desktop, benchmarks
RUN apt-get update 
RUN apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    dpkg \
    figlet \
    gcc \
    gdm3 \    
    git \
    glances \
    glmark2 \
    sed \
    software-properties-common \
    sudo \
    wget \
    xterm \
    xvfb 

RUN apt-get update && \
    apt-get install -y \
    gnome-shell \ 
    gnome-session \ 
    gnome-terminal \
    gpgv \
    grep \
    htop \
    less \
    libfuse2 \
    libglib2.0-0 \
    libxext6 \
    libsm6 \
    libxrender1 \
    lolcat \
    lsb-release \
    mercurial \
    mesa-utils \
    nautilus \
    neofetch \
    nodejs \
    seahorse-nautilus \
    subversion \
    tasksel \
    tmux \
    zsh \
    && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/*

# install XPRA: https://github.com/Xpra-org/xpra/wiki/Download#-linux
RUN curl -O https://xpra.org/gpg.asc && \
    gpg --no-default-keyring --keyring=./xpra-v1.gpg --import ./gpg.asc && \
    gpg --no-default-keyring --keyring=./xpra-v1.gpg --export > xpra.gpg && \
    mv xpra.gpg /etc/apt/trusted.gpg.d/

RUN wget -O "/usr/share/keyrings/xpra.asc" https://xpra.org/xpra.asc && \
    wget -O "/etc/apt/sources.list.d/xpra.sources" https://xpra.org/repos/jammy/xpra.sources && \
    apt-get update --allow-insecure-repositories --allow-unauthenticated -y && \
    apt-get install xpra --allow-unauthenticated -y

# Install VirtualGL
RUN cd /tmp && \
    wget https://sourceforge.net/projects/virtualgl/files/3.1/virtualgl_3.1_amd64.deb/download -O virtualgl_3.1_amd64.deb && \
    dpkg -i --force-depends virtualgl_3.1_amd64.deb && \
    apt -f install -y 

# Create XAuthority configurations
RUN export XAUTHORITY=~/.Xauthority && \
    sed -i -e "s/console/anybody/" /etc/X11/Xwrapper.config && \
#    nvidia-xconfig -a --allow-empty-initial-configuration --enable-all-gpus --use-display-device=none --virtual=1920x1080 -o /etc/X11/xorg.conf --busid=0:6:0 && \
    wget https://gist.githubusercontent.com/tyson-swetnam/3490dc02476818a67a3bcdcba3017678/raw/66885bbfa54a406ce486484a79ece237028c5ee7/xorg.conf -O /etc/X11/xorg.conf
   
# define username as ubuntu and limit its ownership
ARG LOCAL_USER=user

ARG PRIV_CMDS='/bin/ch*,/bin/cat,/bin/gunzip,/bin/tar,/bin/mkdir,/bin/ps,/bin/mv,/bin/cp,/usr/bin/apt*,/usr/bin/pip*,/bin/yum,/bin/snap'

RUN adduser --disabled-password --gecos "ubuntu" --uid 1000 ${LOCAL_USER}  && \
    usermod -aG sudo ${LOCAL_USER} && \
    echo "$LOCAL_USER ALL=NOPASSWD: $PRIV_CMDS" >> /etc/sudoers

# Create user space for xpra
RUN mkdir -p /run/xpra/1000 && \
    chown -R ${LOCAL_USER}:${LOCAL_USER} /run/xpra && \
    mkdir -p /run/${LOCAL_USER}/1000 && \
    chown -R ${LOCAL_USER}:${LOCAL_USER} /run/${LOCAL_USER}

# Install MiniConda and Tini
ENV TZ America/Phoenix
ENV LANG=C.UTF-8 
ENV LC_ALL "en_US.UTF-8"
ENV PATH /opt/conda/bin:$PATH
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
    /bin/bash ~/miniconda.sh -b -p /opt/conda && \
    rm ~/miniconda.sh && \
    ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /home/${LOCAL_USER}/.bashrc && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /home/${LOCAL_USER}/.zshrc && \
    chown -R ${LOCAL_USER}:${LOCAL_USER} /opt/conda

# ENV TINI_VERSION 0.19.0
# RUN apt-get update && \
#    curl -L "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini_${TINI_VERSION}-amd64.deb" > tini.deb && \
#    dpkg -i tini.deb && \
#    rm tini.deb && \
#    apt-get clean && \
#    rm -rf /var/lib/apt/lists/*

# Install Go
RUN wget -q -c https://dl.google.com/go/go1.20.5.linux-amd64.tar.gz -O - | tar -xz -C /usr/local

# install ttyd
RUN curl -L "https://github.com/tsl0922/ttyd/releases/download/1.7.3/ttyd.x86_64" > ttyd && \
    chmod a+x ttyd && \
    mv ttyd /usr/local/bin/ttyd

# getting a locales error
RUN apt-get clean && \
    apt-get install locales -y && \
    locale-gen en_US.UTF-8

# update terminal message
ENV PATH=${PATH}:/usr/games
COPY 01-custom /etc/motd
RUN chmod +x /etc/motd

# Install CyberDuck CLI
# RUN echo "deb https://s3.amazonaws.com/repo.deb.cyberduck.io stable main" > /etc/apt/sources.list.d/cyberduck.list && \
#    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FE7097963FEFBE72 && \
#    apt update && \
#    apt install duck

# Install GitHub CLI
# RUN curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | dd of=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg && \
#    echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/trusted.gpg.d/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" > /etc/apt/sources.list.d/github-cli.list && \
#    apt update && \
#    apt install gh

# Install GoCommmands
RUN cd /usr/local/bin/ && \
    GOCMD_VER=$(curl -L -s https://raw.githubusercontent.com/cyverse/gocommands/main/VERSION.txt); curl -L -s https://github.com/cyverse/gocommands/releases/download/${GOCMD_VER}/gocmd-${GOCMD_VER}-linux-amd64.tar.gz | tar zxvf -

# Install Firefox
RUN add-apt-repository ppa:mozillateam/ppa && \
    echo 'Package: * \ Pin: release o=LP-PPA-mozillateam \ Pin-Priority: 1001' | tee /etc/apt/preferences.d/mozilla-firefox && \
    echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox && \
    apt-get install firefox -y

# ready to set user 
USER ${LOCAL_USER}

# Install OhMyZSH theme
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN echo '[ ! -z "$TERM" -a -r /etc/motd ] && /etc/motd' >> ~/.zshrc

# set path for Go and VirtualGL
ENV PATH=${PATH}:/usr/local/go/bin:/opt/VirtualGL/bin

# set shell as zsh
ENV SHELL=zsh
ENV TERM=linux
ENV DISPLAY=:100

WORKDIR /home/${LOCAL_USER}

# expose port 9876 for Xpra windows
EXPOSE 9876

# changes tmux layout while running
COPY entry.sh /bin
RUN echo 'set-option -g status off' >> ~/.tmux.conf

ENTRYPOINT ["zsh", "/bin/entry.sh"]