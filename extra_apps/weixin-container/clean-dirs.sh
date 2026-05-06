WEIXIN_HOME="$HOME/.local/share/weixin-container-home"

rm -rf "$WEIXIN_HOME/.xwechat/crashinfo/pending"
rm -rf "$WEIXIN_HOME/.xwechat/crashinfo/new"
rm -rf "$WEIXIN_HOME/.xwechat/crashinfo/records"
rm -rf "$WEIXIN_HOME/.xwechat/crashinfo/attachments"

mkdir -p "$WEIXIN_HOME/.xwechat/crashinfo/pending"
mkdir -p "$WEIXIN_HOME/.xwechat/crashinfo/new"
mkdir -p "$WEIXIN_HOME/.xwechat/crashinfo/records"
mkdir -p "$WEIXIN_HOME/.xwechat/crashinfo/attachments"
mkdir -p "$WEIXIN_HOME/.xwechat/crashinfo/completed"

touch "$WEIXIN_HOME/.xwechat/crashinfo/settings.dat"

sudo chown -R "$(id -u):$(id -g)" "$WEIXIN_HOME"
chmod -R u+rwX "$WEIXIN_HOME"
