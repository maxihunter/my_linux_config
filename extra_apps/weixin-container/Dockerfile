FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    ca-certificates \
    dbus-x11 \
    xdg-utils \
    libnss3 \
    libxss1 \
    libasound2 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    libgbm1 \
    libx11-xcb1 \
    libxcb-dri3-0 \
    libatomic1 \
    libpulse0 \
    libxkbcommon0 \
    libxkbcommon-x11-0 \
    libxcb-xkb1 \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-render-util0 \
    libxcb-keysyms1 \
    libxcb-cursor0 \
    libxcb-randr0 \
    libxcb-shape0 \
    libxcb-sync1 \
    libxcb-xfixes0 \
    libxrender1 \
    libxi6 \
    libxtst6 \
    libxcomposite1 \
    libxdamage1 \
    libxrandr2 \
    libgl1 \
    libegl1 \
    libwayland-client0 \
    libwayland-cursor0 \
    libwayland-egl1 \
    libnotify4 \
    fonts-noto-cjk \
    && rm -rf /var/lib/apt/lists/*

COPY WeChatLinux_x86_64.deb /tmp/weixin.deb

RUN apt-get update \
    && apt-get install -y /tmp/weixin.deb \
    && rm -rf /var/lib/apt/lists/* /tmp/weixin.deb

ARG USER_ID=1000
ARG GROUP_ID=1000

RUN groupadd --gid ${GROUP_ID} weixin \
    && useradd \
       --create-home \
       --home-dir /home/weixin \
       --uid ${USER_ID} \
       --gid ${GROUP_ID} \
       --shell /bin/bash \
       weixin

RUN mkdir -p /tmp/runtime-weixin/pulse \
    && chown -R ${USER_ID}:${GROUP_ID} /tmp/runtime-weixin \
    && chmod 700 /tmp/runtime-weixin

COPY entrypoint.sh /usr/local/bin/weixin-entrypoint
RUN chmod +x /usr/local/bin/weixin-entrypoint

USER weixin

ENV HOME=/home/weixin
ENV XDG_RUNTIME_DIR=/tmp/runtime-weixin
ENV QT_QPA_PLATFORM=wayland
ENV GDK_BACKEND=wayland
ENV ELECTRON_OZONE_PLATFORM_HINT=wayland
ENV MOZ_ENABLE_WAYLAND=1

WORKDIR /home/weixin

ENTRYPOINT ["/usr/local/bin/weixin-entrypoint"]
