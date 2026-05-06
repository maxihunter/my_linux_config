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

exec /opt/wechat/wechat --no-sandbox "$@"
