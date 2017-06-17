#!/bin/sh

# arugment
USER_NAME=$1
KEY_PATH=$2

password() {
  for i in `seq 1 1 2`
  do
    sleep 1;echo "test"
  done
}

enter() {
  for i in `seq 1 1 6`
  do
    sleep 1;echo ""
  done
}

if [ $# -ne 2 ]; then
  echo "指定された引数は$#個です。" 1>&2
  echo "実行するには2個の引数が必要です。" 1>&2
  exit 1
fi

# add user
(password;enter;)|adduser $USER_NAME

# set public key
mkdir /home/$USER_NAME/.ssh
cd /home/$USER_NAME/.ssh
cat $KEY_PATH >> authorized_keys
chmod 600 /home/$USER_NAME/.ssh/authorized_keys
