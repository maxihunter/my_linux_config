#!/usr/bin/env bash
set -e

WEIXIN_HOME="$HOME/.local/share/weixin-container-home"
CONTAINER_RUNTIME="/tmp/runtime-weixin"

mkdir -p "$WEIXIN_HOME"

if [ -z "$DISPLAY" ]; then
  echo "DISPLAY is empty. XWayland may not be available."
  exit 1
fi

# Allow local same-user X11/XWayland connection
xhost +SI:localuser:"$USER" >/dev/null 2>&1 || true

ARGS=(
  run --rm
  --name weixin
  --userns=keep-id
  --security-opt=no-new-privileges
  --cap-drop=ALL
  --shm-size=1g

  -e "HOME=/home/weixin"
  -e "DISPLAY=$DISPLAY"
  -e "XDG_RUNTIME_DIR=$CONTAINER_RUNTIME"
  -e "QT_QPA_PLATFORM=xcb"
  -e "GDK_BACKEND=x11"
  -e "NO_AT_BRIDGE=1"

  -v /tmp/.X11-unix:/tmp/.X11-unix:ro
  -v "$WEIXIN_HOME:/home/weixin"

  --device /dev/dri
)

# DBus, optional
if [ -S "$XDG_RUNTIME_DIR/bus" ]; then
  ARGS+=(
    -e "DBUS_SESSION_BUS_ADDRESS=unix:path=$CONTAINER_RUNTIME/bus"
    -v "$XDG_RUNTIME_DIR/bus:$CONTAINER_RUNTIME/bus"
  )
fi

# Audio, optional
if [ -S "$XDG_RUNTIME_DIR/pulse/native" ]; then
  ARGS+=(
    -e "PULSE_SERVER=unix:$CONTAINER_RUNTIME/pulse/native"
    -v "$XDG_RUNTIME_DIR/pulse/native:$CONTAINER_RUNTIME/pulse/native"
  )
fi

ARGS+=(weixin-container)

exec podman "${ARGS[@]}"
