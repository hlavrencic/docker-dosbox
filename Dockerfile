FROM debian:bullseye

# Install supervisor, VNC, & X11 packages
RUN set -ex; \
    apt-get update; \
    apt-get install -y \
      bash \
      fluxbox \
      net-tools \
      novnc \
      supervisor \
      x11vnc \
      xterm \
      xvfb \
      dosbox; \
    rm -rfv /var/lib/apt/lists/*

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
    RUN_FLUXBOX=no \
    VNC_PASSWD=dosbox
COPY . /app
CMD ["/app/entrypoint.sh"]
EXPOSE 8080
