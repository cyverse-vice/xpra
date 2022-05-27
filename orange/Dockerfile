FROM harbor.cyverse.org/vice/xpra/desktop:20.04

USER root

# Install Python and linux depends
RUN apt-get update \
    && apt-get install -y g++ virtualenv build-essential 

# define username as orange and limit its ownership
ARG LOCAL_USER=orange

ARG PRIV_CMDS='/bin/ch*,/bin/cat,/bin/gunzip,/bin/tar,/bin/mkdir,/bin/ps,/bin/mv,/bin/cp,/usr/bin/apt*,/usr/bin/pip*,/bin/yum'

RUN adduser --disabled-password --gecos "orange" --uid 1001 ${LOCAL_USER}  && \
    usermod -aG sudo ${LOCAL_USER} && \
    echo "$LOCAL_USER ALL=NOPASSWD: $PRIV_CMDS" >> /etc/sudoers

# Create user space for xpra
RUN mkdir -p /run/xpra/1001 && \
    chown -R ${LOCAL_USER}:${LOCAL_USER} /run/xpra && \
    mkdir -p /run/${LOCAL_USER}/1001 && \
    chown -R ${LOCAL_USER}:${LOCAL_USER} /run/${LOCAL_USER} && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /home/${LOCAL_USER}/.bashrc && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> /home/${LOCAL_USER}/.zshrc && \
    chown -R ${LOCAL_USER}:1000 /opt/conda

# Create Orange user
ENV USER orange
ENV PASSWORD orange
ENV HOME /home/orange
RUN echo orange:1000 | chpasswd
RUN gpasswd -a orange sudo

ADD ./icons/orange.png /usr/share/backgrounds/images/orange.png
ADD ./icons/orange.png .conda/share/orange3/orange.png
ADD ./orange/orange-canvas.desktop /home/${LOCAL_USER}Desktop/orange-canvas.desktop

USER orange
WORKDIR /home/orange

# create conda environment for Orange
COPY environment.yml /home/orange/environment.yml
RUN conda install -c conda-forge -y mamba && \
    mamba env create -f environment.yml

# Activate Orange conda environments in bash and zsh
RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc && \
    echo "conda activate orange" >> ~/.bashrc
RUN sudo chown -R orange:1000 /home/orange && \
    echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.zshrc && \
    echo "conda activate orange" >> ~/.zshrc

# set shell as zsh
ENV SHELL=zsh
ENV TERM=linux

ENV DISPLAY=:100
EXPOSE 9876

# changes tmux layout while running
COPY entry.sh /bin
RUN echo 'set-option -g status off' >> ~/.tmux.conf

# add iRODS iCommands to user profile as JSON
RUN mkdir -p /home/orange/.irods 

ENTRYPOINT ["zsh", "/bin/entry.sh"]