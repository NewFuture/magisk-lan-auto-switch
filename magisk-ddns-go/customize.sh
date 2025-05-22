#!/system/bin/sh

OLD_CONFIG_FILE="/data/adb/modules/ddns-go/config.yaml"
OLD_ENV_FILE="/data/adb/modules/ddns-go/env"


# get latest from https://github.com/jeessy2/ddns-go/releases/latest/
DOWNLOAD_URL=$(curl -s https://api.github.com/repos/jeessy2/ddns-go/releases/latest | grep -o 'https:.*android_arm64.*tar.gz')
if [ -z "$DOWNLOAD_URL" ]; then
    echo "Failed to get the latest url."
    exit 1
else
    echo "Latest version url: $DOWNLOAD_URL"
fi

# download ddns-go
mkdir -p $MODPATH/system/vendor/bin
curl -L -o ddns-go.tar.gz $DOWNLOAD_URL
# only extract ddns-go binary
tar -xzf ddns-go.tar.gz -C $MODPATH/system/vendor/bin -z ddns-go
rm -f ddns-go.tar.gz

chmod +x $MODPATH/system/vendor/bin/*
set_perm_recursive $MODPATH/system/vendor/bin/ 0 0 0755 0755

if [ -f "$OLD_CONFIG_FILE" ]; then
    echo "Found old config file at $OLD_CONFIG_FILE. Moving to new location."
    cp "$OLD_CONFIG_FILE" "$MODPATH"
    echo "COPY config file to $MODPATH"
fi

if [ -f "$OLD_ENV_FILE" ]; then
    echo "Found old config file at $OLD_ENV_FILE. Moving to new location."
    cp "$OLD_ENV_FILE" "$MODPATH"
    echo "COPY config file to $MODPATH"
fi
