## Cocos2dx
if [ -d "$EXTERNAL/cocos2d-x" ]; then
    cd "$EXTERNAL/cocos2d-x" && git pull
else
    sudo -u $SUDO_USER git clone https://github.com/cocos2d/cocos2d-x.git "$EXTERNAL/cocos2d-x"
    cd "$EXTERNAL/cocos2d-x"
fi

sudo -u $SUDO_USER python download-deps.py
sudo -u $SUDO_USER git submodule update --init
