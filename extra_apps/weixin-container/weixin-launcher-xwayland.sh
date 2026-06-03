#!/usr/bin/env bash
set -e

CONTAINER_NAME="weixin"
IMAGE_NAME="weixin-container"
WEIXIN_HOME="$HOME/.local/share/weixin-container-home"

HOST_RUNTIME="${XDG_RUNTIME_DIR:-/run/user/$(id -u)}"
IBUS_ADDRESS_HOST="$(ibus address 2>/dev/null || true)"

mkdir -p "$WEIXIN_HOME"

if [ -z "${DISPLAY:-}" ]; then
  echo "DISPLAY is empty. XWayland may not be available."
  exit 1
fi

if [ -z "$IBUS_ADDRESS_HOST" ]; then
  echo "Warning: ibus address is empty. Chinese input may not work."
fi

# Allow local same-user X11/XWayland connection.
xhost +SI:localuser:"$USER" >/dev/null 2>&1 || true

ARGS=(
  run --rm --replace
  --name "$CONTAINER_NAME"

  # Required for WeChat/Chromium to accept host IBUS_DAEMON_PID.
  --pid=host

  --userns=keep-id
  --security-opt=no-new-privileges
  --cap-drop=ALL
  --shm-size=1g

  # Basic environment
  -e "HOME=/home/weixin"
  -e "DISPLAY=$DISPLAY"
  -e "XDG_RUNTIME_DIR=$HOST_RUNTIME"
  -e "DBUS_SESSION_BUS_ADDRESS=${DBUS_SESSION_BUS_ADDRESS:-unix:path=$HOST_RUNTIME/bus}"

  # Locale
  -e "LANG=${LANG:-en_US.UTF-8}"
  -e "LC_CTYPE=${LC_CTYPE:-${LANG:-en_US.UTF-8}}"

  # X11/XWayland mode
  -e "QT_QPA_PLATFORM=xcb"
  -e "GDK_BACKEND=x11"
  -e "NO_AT_BRIDGE=1"

  # IBus input method
  -e "GTK_IM_MODULE=ibus"
  -e "QT_IM_MODULE=ibus"
  -e "XMODIFIERS=@im=ibus"
  -e "SDL_IM_MODULE=ibus"
  -e "GLFW_IM_MODULE=ibus"
  -e "IBUS_ENABLE_SYNC_MODE=1"
  -e "IBUS_ADDRESS=$IBUS_ADDRESS_HOST"

  # X11/XWayland socket
  -v /tmp/.X11-unix:/tmp/.X11-unix:ro

  # Host runtime dir: DBus, PulseAudio, etc.
  -v "$HOST_RUNTIME:$HOST_RUNTIME"

  # Persistent app home
  -v "$WEIXIN_HOME:/home/weixin"

  # IBus bus files and socket
  -v "$HOME/.config/ibus/bus:/home/weixin/.config/ibus/bus:ro"
  -v "$HOME/.cache/ibus:$HOME/.cache/ibus"

  # Match host machine-id so IBus bus filename matches.
  -v /etc/machine-id:/etc/machine-id:ro
  -v /etc/machine-id:/var/lib/dbus/machine-id:ro

  # GPU acceleration
  --device /dev/dri
)

# Audio via PulseAudio/PipeWire Pulse compatibility.
if [ -S "$HOST_RUNTIME/pulse/native" ]; then
  ARGS+=(
    -e "PULSE_SERVER=unix:$HOST_RUNTIME/pulse/native"
  )
fi

ARGS+=("$IMAGE_NAME")

exec podman "${ARGS[@]}"
