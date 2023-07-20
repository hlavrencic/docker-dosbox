FROM debian:bullseye

# Install git, supervisor, VNC, & X11 packages
RUN set -ex; \
    apt-get update; \
    apt-get install -y \
      bash \
      fluxbox \
      git \
      net-tools \
      novnc \
      supervisor \
      x11vnc \
      xterm \
      xvfb

# Setup demo environment variables
ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=1024 \
    DISPLAY_HEIGHT=768 \
    RUN_XTERM=no \
    RUN_FLUXBOX=yes
COPY . /app
CMD ["/app/entrypoint.sh"]
EXPOSE 8080

# Install dosbox
RUN apt install -y dosbox && \
    rm -rfv /var/lib/apt/lists/*

COPY dosbox.conf /app/conf.d/

### get games from https://dosgames.com/

### Add games to image...
# COPY game1.tar.gz /root/dos/game1
# COPY game2 /root/dos/game2

### ... or use from volume
# VOLUME /root/dos/
