#!/bin/bash

for dir in magisk*/; do
    if [ -d "$dir" ]; then
        MODULE_NAME=$(basename "$dir")
        VERSION=$(grep '^version=' "$dir/module.prop" | cut -d'=' -f2)
        VERSION_CODE=$(grep '^versionCode=' "$dir/module.prop" | cut -d'=' -f2)
        ZIP_NAME="${MODULE_NAME}-${VERSION}.zip"
        cd "$dir"
        mkdir -p META-INF/com/google/android
        echo "#MAGISK" > META-INF/com/google/android/updater-script
        wget https://raw.githubusercontent.com/topjohnwu/Magisk/refs/heads/master/scripts/module_installer.sh -O META-INF/com/google/android/update-binary
        chmod +x META-INF/com/google/android/update-binary
        zip -r9 "../$ZIP_NAME" . -x "README.md"
cat <<EOF > ../$MODULE_NAME.update.json
{
  "version": "$VERSION",
  "versionCode": $VERSION_CODE,
  "zipUrl": "https://github.com/NewFuture/magisk-modules/releases/download/latest/$ZIP_NAME",
  "changelog": "",
  "minMagisk": "24.0"
}
EOF
        cd ..
        echo "Packaged $ZIP_NAME"
    fi
done