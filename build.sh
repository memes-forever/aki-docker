#!/bin/bash

# get config
. ./config

CURRENT_WORK_DIR=$(pwd)
APP_FOLDER=app
SPT_AKI_SERVER_FOLDER=Server
SPT_AKI_SERVER_PROJECT_FOLDER=$SPT_AKI_SERVER_FOLDER/project


if [ ! -d $APP_FOLDER ]; then
  echo "Create dir $APP_FOLDER ..."
  mkdir -p $APP_FOLDER
  mkdir -p $APP_FOLDER/Aki_Data
  mkdir -p $APP_FOLDER/user
  mkdir -p $APP_FOLDER/user/mods
fi


echo "WARNINGS! ./run build REPLACE ON DEFAULT ALL CONFIG FILE FROM $APP_FOLDER/Aki_Data/SERVER/configs !!!!!!!!!"


echo "Update SPT_AKI_SERVER from branch $SPT_AKI_SERVER_BRANCH ..."
if [ ! -d $SPT_AKI_SERVER_FOLDER ]; then
  git clone -b $SPT_AKI_SERVER_BRANCH https://dev.sp-tarkov.com/SPT-AKI/Server.git
else
  cd $SPT_AKI_SERVER_FOLDER || exit
  git reset --hard $SPT_AKI_SERVER_BRANCH
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
cp $SPT_AKI_SERVER_PROJECT_FOLDER/package.json $APP_FOLDER/package.json
cp $SPT_AKI_SERVER_PROJECT_FOLDER/.parcelrc $APP_FOLDER/.parcelrc
cp $SPT_AKI_SERVER_PROJECT_FOLDER/tsconfig.json $APP_FOLDER/tsconfig.json
cp $SPT_AKI_SERVER_PROJECT_FOLDER/base_tsconfig.json $APP_FOLDER/base_tsconfig.json
cp -R $SPT_AKI_SERVER_PROJECT_FOLDER/src $APP_FOLDER/src
cp -R $SPT_AKI_SERVER_PROJECT_FOLDER/assets $APP_FOLDER/Aki_Data/Server
echo "End copy files."


echo "----------------------------------------------------------------"
