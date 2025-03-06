FROM debian:bullseye

# Set environment variables to mitigate QEMU issues with Python
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONMALLOC=malloc \
    LANG=en_US.UTF-8

# Ensure APT uses HTTPS correctly by installing ca-certificates
RUN apt-get update && \
    apt-get install -y --no-install-recommends ca-certificates && \
    rm -rf /var/lib/apt/lists/*

# Update keyring (to avoid repository signature issues)
RUN apt-get update && \
    apt-get install -y --no-install-recommends debian-archive-keyring && \
    rm -rf /var/lib/apt/lists/*

RUN apt-get update && apt-get install -y --no-install-recommends \
      bash \
      fluxbox \
      net-tools \
      novnc \
      supervisor \
      x11vnc \
      xterm \
      xvfb \
      dosbox \
      dos2unix && \
    rm -rf /var/lib/apt/lists/*

# Setup demo environment variables
ENV HOME=/root \
    DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    LC_ALL=C.UTF-8 \
    DISPLAY=:0.0 \
    DISPLAY_WIDTH=640 \
    DISPLAY_HEIGHT=480 \
    RUN_XTERM=no \
    RUN_FLUXBOX=no \
    VNC_PASSWD=dosbox

COPY conf.d/ /app/conf.d/
COPY dosbox/ /app/dosbox/
COPY entrypoint.sh /app/entrypoint.sh
COPY supervisord.conf /app/supervisord.conf

RUN dos2unix /app/entrypoint.sh
RUN chmod +x /app/entrypoint.sh
#RUN sed -i '1s/^\xef\xbb\xbf//' /app/entrypoint.sh

VOLUME ["/dos"]
VOLUME ["/mount"]

CMD ["/app/entrypoint.sh"]
EXPOSE 8080

#docker build -t hn8888/dosbox .
#docker run -v ./dos:/dos -v ./mount:/mount -p 8080:8080 hn8888/dosbox