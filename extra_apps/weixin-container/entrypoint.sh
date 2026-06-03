#!/usr/bin/env bash
set -e

export HOME=/home/weixin
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-/tmp/runtime-weixin}"

mkdir -p "$HOME"
mkdir -p "$HOME/Downloads"
mkdir -p "$HOME/.config"
mkdir -p "$HOME/.cache"
mkdir -p "$HOME/.local/share"

# Clean stale crash reporter state
rm -rf "$HOME/.xwechat/crashinfo/pending"
rm -rf "$HOME/.xwechat/crashinfo/new"
rm -rf "$HOME/.xwechat/crashinfo/records"
rm -rf "$HOME/.xwechat/crashinfo/attachments"

mkdir -p "$HOME/.xwechat/crashinfo/pending"
mkdir -p "$HOME/.xwechat/crashinfo/new"
mkdir -p "$HOME/.xwechat/crashinfo/records"
mkdir -p "$HOME/.xwechat/crashinfo/attachments"
mkdir -p "$HOME/.xwechat/crashinfo/completed"

touch "$HOME/.xwechat/crashinfo/settings.dat"

chmod -R u+rwX "$HOME/.xwechat" || true

mkdir -p "$XDG_RUNTIME_DIR"
chmod 700 "$XDG_RUNTIME_DIR" || true

export NO_AT_BRIDGE=1

#exec /opt/wechat/wechat --no-sandbox "$@"
export GTK_IM_MODULE="${GTK_IM_MODULE:-ibus}"
export QT_IM_MODULE="${QT_IM_MODULE:-ibus}"
export XMODIFIERS="${XMODIFIERS:-@im=ibus}"
export SDL_IM_MODULE="${SDL_IM_MODULE:-ibus}"
export GLFW_IM_MODULE="${GLFW_IM_MODULE:-ibus}"
export IBUS_ENABLE_SYNC_MODE="${IBUS_ENABLE_SYNC_MODE:-1}"

#echo "=== WeChat IM debug ==="
#echo "HOME=$HOME"
#echo "DISPLAY=$DISPLAY"
#echo "XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR"
#echo "DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS"
#echo "GTK_IM_MODULE=$GTK_IM_MODULE"
#echo "QT_IM_MODULE=$QT_IM_MODULE"
#echo "XMODIFIERS=$XMODIFIERS"
#echo "IBUS_ADDRESS=$IBUS_ADDRESS"
#echo "container /etc/machine-id=$(cat /etc/machine-id 2>/dev/null || true)"
#echo "container /var/lib/dbus/machine-id=$(cat /var/lib/dbus/machine-id 2>/dev/null || true)"
#echo
#echo "IBus bus dir:"
#ls -la "$HOME/.config/ibus/bus" || true
#echo "======================="

exec /opt/wechat/wechat \
  --no-sandbox \
  --gtk-version=3 \
  --ozone-platform=x11
