#!/bin/bash

# get config
. ./.settings


SPT_AKI_SERVER_FOLDER=Server
SPT_AKI_SERVER_PROJECT_FOLDER=$SPT_AKI_SERVER_FOLDER/project


echo "WARNINGS! ./run build REPLACE ON DEFAULT ALL CONFIG FILE FROM $APP_FOLDER/Aki_Data/SERVER/configs !!!!!!!!!"

docker-compose down


if [ -d $APP_FOLDER ]; then
  rm -rf $APP_FOLDER/
fi


echo "Create dir $APP_FOLDER ..."
mkdir -p node_modules
mkdir -p profiles
mkdir -p mods
mkdir -p $APP_FOLDER
mkdir -p $APP_FOLDER/Aki_Data
mkdir -p $APP_FOLDER/user
mkdir -p $APP_FOLDER/user/mods


echo "Update SPT_AKI_SERVER from branch $SPT_AKI_SERVER_BRANCH ..."
if [ ! -d $SPT_AKI_SERVER_FOLDER ]; then
  git clone -b $SPT_AKI_SERVER_BRANCH https://dev.sp-tarkov.com/SPT-AKI/Server.git
  cd $SPT_AKI_SERVER_FOLDER || exit
  git log -1
  cd $CURRENT_WORK_DIR || exit
else
  cd $SPT_AKI_SERVER_FOLDER || exit
  git checkout $SPT_AKI_SERVER_BRANCH
  git reset --hard
  git pull
  git lfs fetch
  git lfs pull
  git log -1
  cd $CURRENT_WORK_DIR || exit
fi


echo "Update SIT_AKI_SERVER_MOD from $SIT_AKI_SERVER_MOD_BRANCH"
if [ ! -d mods/SITCoop ]; then
  cd mods || exit
  git clone -b $SIT_AKI_SERVER_MOD_BRANCH https://github.com/paulov-t/SIT.Aki-Server-Mod.git
  mv SIT.Aki-Server-Mod SITCoop
  cd SITCoop || exit
  git log -1
  cd $CURRENT_WORK_DIR || exit
else
  cd mods/SITCoop || exit
  git checkout $SIT_AKI_SERVER_MOD_BRANCH
  git reset --hard
  git pull
  git log -1
  cd $CURRENT_WORK_DIR || exit
fi


FILES_TO_COPY=(package.json .parcelrc tsconfig.json base_tsconfig.json)
DIRS_TO_COPY=(src assets)


echo "Start copy files from SPT_AKI_SERVER in $APP_FOLDER ..."
for i in ${FILES_TO_COPY[*]}; do
  echo "copy $SPT_AKI_SERVER_PROJECT_FOLDER/${i} -> $APP_FOLDER/${i}"
  cp $SPT_AKI_SERVER_PROJECT_FOLDER/${i} $APP_FOLDER/${i}
done

for i in ${DIRS_TO_COPY[*]}; do
  echo "copy dir $SPT_AKI_SERVER_PROJECT_FOLDER/${i} -> $APP_FOLDER/${i}"
  cp -r $SPT_AKI_SERVER_PROJECT_FOLDER/${i} $APP_FOLDER/${i}
done


echo "Start copy SITCoop in $APP_FOLDER ..."
cp -r mods/SITCoop $APP_FOLDER/user/mods/SITCoop
mv $APP_FOLDER/assets $APP_FOLDER/Aki_Data/Server

echo "----------------------------------------------------------------"
