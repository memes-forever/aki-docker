#!/bin/bash

# get config
. ./.config


PROFILES_FOLDER=app/user/profiles


ARGS1=$1
ARGS2=$2


mkdir -p $BACKUP_PROFILES_FOLDER


if [ "$ARGS1" = "backup_profiles" ]; then

  tar czvf ./$BACKUP_PROFILES_FOLDER/backup-$(date +%Y-%m-%d.%H).tar ./$PROFILES_FOLDER
  echo "Backup save"

  cd $BACKUP_PROFILES_FOLDER || exit
  OLDEST_FILES=$(ls -t | tail -n +721)
  if [ "$OLDEST_FILES" ]; then
    rm $OLDEST_FILES
    echo "Backup remove old $OLDEST_FILES"
  fi

elif [ "$ARGS1" = "backup_list" ]; then

  echo "Backup list"
  ls -t ./$BACKUP_PROFILES_FOLDER

elif [ "$ARGS1" = "backup_restore" ]; then

  tar -xvzf ./$BACKUP_PROFILES_FOLDER/$ARGS2 -C ./
  echo "Backup Restore"

else

  echo "backup profiles  ./backup.sh backup_profiles"
  echo "backup list  ./backup.sh backup_list"
  echo "unzip profiles  ./backup.sh backup_restore backup-<date>.tar"

fi


echo "----------------------------------------------------------------"
