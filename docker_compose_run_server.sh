#!/bin/bash

echo "Get config"
. ./.settings
INTERNAL_IP=0.0.0.0
REPLACEMENT_WORK_DIR=C:/snapshot/project


echo "Prepare run ..."
stringContain() { case $2 in *$1* ) return 0;; *) return 1;; esac ;}
cd app

echo "Fix mods files ..."
for i in $( find ./src -name "*.ts" ); do
  # if ! stringContain "node_modules" "${i}"; then
  if grep -q "$REPLACEMENT_WORK_DIR" ${i}; then
    echo "${i} $REPLACEMENT_WORK_DIR -> $CURRENT_WORK_DIR/app"
    sed -i "s@$REPLACEMENT_WORK_DIR@$CURRENT_WORK_DIR/app@g" ${i}
  fi
  # fi
done

if [ ! -d ./user/mods/SITCoop/config/coopConfig.json ]; then
  bash -c "sleep 60; pkill -f npx"&
else
  echo "Change ip on $INTERNAL_IP in /Aki_Data/Server/configs/http.json"
  sed -i -e "s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/$INTERNAL_IP/g" ./Aki_Data/Server/configs/http.json

  echo "Change ip on $EXTERNAL_IP in /user/mods/SITCoop/config/coopConfig.json"
  sed -i -e "s/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/$EXTERNAL_IP/g" ./user/mods/SITCoop/config/coopConfig.json

  echo "Change useExternalIPFinder on $USE_EXTERNAL_IP_FINDER in /user/mods/SITCoop/config/coopConfig.json"
  sed -i -e "s/\"useExternalIPFinder\": [a-zA-Z]*,/\"useExternalIPFinder\": $USE_EXTERNAL_IP_FINDER,/g" ./user/mods/SITCoop/config/coopConfig.json
fi


echo "Start server, please wait ..."
npx ts-node -r tsconfig-paths/register src/ide/ReleaseEntry.ts
