#!/bin/bash

# get config
. ./.config


SPT_AKI_SERVER_FOLDER=Server
SPT_AKI_SERVER_PROJECT_FOLDER=$SPT_AKI_SERVER_FOLDER/project


echo "WARNINGS! ./run build REPLACE ON DEFAULT ALL CONFIG FILE FROM $APP_FOLDER/Aki_Data/SERVER/configs !!!!!!!!!"

docker-compose down

FILES_TO_COPY=(package.json .parcelrc tsconfig.json base_tsconfig.json)
DIRS_TO_COPY=(src)


if [ ! -d $APP_FOLDER ]; then
  echo "Create dir $APP_FOLDER ..."
  mkdir -p $APP_FOLDER
  mkdir -p $APP_FOLDER/Aki_Data
  mkdir -p $APP_FOLDER/user
  mkdir -p $APP_FOLDER/node_modules
  mkdir -p $APP_FOLDER/user/mods
else
  echo "Remove old files ..."
  for i in ${FILES_TO_COPY[*]}; do
    echo "rm $APP_FOLDER/${i}"
    rm $APP_FOLDER/${i}
  done

  for i in ${DIRS_TO_COPY[*]}; do
    echo "rm dir $APP_FOLDER/${i}"
    rm -R $APP_FOLDER/${i}
  done

  echo "rm dir $APP_FOLDER/Aki_Data/Server"
  rm -R $APP_FOLDER/Aki_Data/Server
  echo "rm $APP_FOLDER/node_modules/*"
  rm -rf $APP_FOLDER/node_modules
  mkdir -p $APP_FOLDER/node_modules
  echo "End Remove"
fi


echo "Update SPT_AKI_SERVER from branch $SPT_AKI_SERVER_BRANCH ..."
if [ ! -d $SPT_AKI_SERVER_FOLDER ]; then
  git clone -b $SPT_AKI_SERVER_BRANCH https://dev.sp-tarkov.com/SPT-AKI/Server.git
else
  cd $SPT_AKI_SERVER_FOLDER || exit
  git reset --hard $SPT_AKI_SERVER_BRANCH
  git pull
  git lfs fetch
  git lfs pull
  cd $CURRENT_WORK_DIR || exit
fi


echo "Update SIT_AKI_SERVER_MOD from $SIT_AKI_SERVER_MOD_BRANCH"
if [ ! -d $APP_FOLDER/user/mods/SITCoop ]; then
  cd $APP_FOLDER/user/mods || exit
  git clone -b $SIT_AKI_SERVER_MOD_BRANCH https://github.com/paulov-t/SIT.Aki-Server-Mod.git
  mv SIT.Aki-Server-Mod SITCoop
  cd $CURRENT_WORK_DIR || exit
else
  cd $APP_FOLDER/user/mods/SITCoop || exit
  git reset --hard $SIT_AKI_SERVER_MOD_BRANCH
  git pull
  cd $CURRENT_WORK_DIR || exit
fi


echo "Start copy files from SPT_AKI_SERVER in $APP_FOLDER ..."
for i in ${FILES_TO_COPY[*]}; do
  echo "copy $SPT_AKI_SERVER_PROJECT_FOLDER/${i} -> $APP_FOLDER/${i}"
  cp $SPT_AKI_SERVER_PROJECT_FOLDER/${i} $APP_FOLDER/${i}
done

for i in ${DIRS_TO_COPY[*]}; do
  echo "copy dir $SPT_AKI_SERVER_PROJECT_FOLDER/${i} -> $APP_FOLDER/${i}"
  cp -R $SPT_AKI_SERVER_PROJECT_FOLDER/${i} $APP_FOLDER/${i}
done

echo "copy dir $SPT_AKI_SERVER_PROJECT_FOLDER/assets -> $APP_FOLDER/Aki_Data/Server"
cp -R $SPT_AKI_SERVER_PROJECT_FOLDER/assets $APP_FOLDER/Aki_Data/Server
echo "End copy files."

echo "----------------------------------------------------------------"
