FROM harbor.cyverse.org/vice/xpra/desktop:20.04

USER root

# Install Python and linux depends
RUN apt-get update \
    && apt-get install -y g++ virtualenv build-essential 

# Create Orange user
ENV USER orange
ENV PASSWORD orange
ENV HOME /home/orange
RUN useradd -m -s /bin/bash orange
RUN echo orange:orange | chpasswd
RUN gpasswd -a orange sudo

ADD ./icons/orange.png /usr/share/backgrounds/images/orange.png
ADD ./icons/orange.png .conda/share/orange3/orange.png
ADD ./orange/orange-canvas.desktop Desktop/orange-canvas.desktop

USER orange

# Install Orange3
COPY environment.yml environment.yml
RUN conda env create -f environment.yml

ENV conda init 
ENV conda activate orange

WORKDIR /home/orange

# set shell as zsh
ENV SHELL=zsh
ENV TERM=linux

ENV DISPLAY=:100

EXPOSE 9876

# changes tmux layout while running
COPY entry.sh /bin
RUN echo 'set-option -g status off' >> ~/.tmux.conf

# add iRODS iCommands to user profile as JSON
RUN mkdir /home/orange/.irods 

ENTRYPOINT ["zsh", "/bin/entry.sh"]