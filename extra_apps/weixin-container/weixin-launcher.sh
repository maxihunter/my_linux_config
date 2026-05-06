#!/usr/bin/env bash
set -e

WEIXIN_HOME="$HOME/.local/share/weixin-container-home"
CONTAINER_RUNTIME="/tmp/runtime-weixin"

mkdir -p "$WEIXIN_HOME"

if [ -z "$WAYLAND_DISPLAY" ]; then
  echo "WAYLAND_DISPLAY is empty. Are you using Wayland?"
  exit 1
fi

if [ -z "$XDG_RUNTIME_DIR" ]; then
  echo "XDG_RUNTIME_DIR is empty."
  exit 1
fi

WAYLAND_SOCKET="$XDG_RUNTIME_DIR/$WAYLAND_DISPLAY"

if [ ! -S "$WAYLAND_SOCKET" ]; then
  echo "Wayland socket not found: $WAYLAND_SOCKET"
  exit 1
fi

ARGS=(
  run --rm
  --name weixin
  --userns=keep-id
  --security-opt=no-new-privileges
  --cap-drop=ALL
  --shm-size=1g

  -e "HOME=/home/weixin"
  -e "XDG_RUNTIME_DIR=$CONTAINER_RUNTIME"
  -e "WAYLAND_DISPLAY=$WAYLAND_DISPLAY"
  -e "QT_QPA_PLATFORM=wayland"
  -e "GDK_BACKEND=wayland"
  -e "ELECTRON_OZONE_PLATFORM_HINT=wayland"
  -e "MOZ_ENABLE_WAYLAND=1"
  -e "NO_AT_BRIDGE=1"

  -v "$WAYLAND_SOCKET:$CONTAINER_RUNTIME/$WAYLAND_DISPLAY"
  -v "$WEIXIN_HOME:/home/weixin"

  --device /dev/dri

  weixin-container
)

# Optional DBus session bus. Some desktop apps need this.
if [ -S "$XDG_RUNTIME_DIR/bus" ]; then
  ARGS+=(
    -e "DBUS_SESSION_BUS_ADDRESS=unix:path=$CONTAINER_RUNTIME/bus"
    -v "$XDG_RUNTIME_DIR/bus:$CONTAINER_RUNTIME/bus"
  )
fi

# Optional PulseAudio/PipeWire compatibility
if [ -S "$XDG_RUNTIME_DIR/pulse/native" ]; then
  ARGS+=(
    -e "PULSE_SERVER=unix:$CONTAINER_RUNTIME/pulse/native"
    -v "$XDG_RUNTIME_DIR/pulse/native:$CONTAINER_RUNTIME/pulse/native"
  )
fi

exec podman "${ARGS[@]}"
