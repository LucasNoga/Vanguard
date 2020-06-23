#!/bin/bash

# ------------------------------------------------------------------
# [Author] : Lucas Noga
# [Title] : Password Handler
# [Description] : Password manager to get your password in your clipboard
# [Version] : 1.0
# [Usage] : pass <key_password>"
# ------------------------------------------------------------------

VERSION=1.0
USAGE="Usage: pass <key_password>"

main(){
  if [ $# = 0 ]
  then
    get_all_passwords
  else
    SERVER=$1
    CLOUD_INSTANCE=$2

    # si c'est un mot de passe de cloud on recupere l'instance au lieu du serveur
    if [ "$SERVER" = "cloud" ]
    then
      if [ "$CLOUD_INSTANCE" != "" ]
      then
        password=$(get_password $CLOUD_INSTANCE)
      fi
    else
      if [ "$SERVER" != "" ]
      then
        password=$(get_password $SERVER)
      fi
    fi

    # Copy the password if existing
    if [ -z "$password" ]
    then
      echo password null
      echo -e '\e[91m\e[1mPassword Unknown\e[0m'
    else
      echo password not null
      copy_clipboard $password
      echo -e '\e[93mPassword copy into the clipboard\e[0m';
      exit 0
    fi
fi
}

# HASHMAP for password list
declare -A passwords=(
    ["id1"]=$'password1'
    ["id2"]=$'password2'
    ["id3"]=$'password3'
)

get_all_passwords(){
    for key in "${!passwords[@]}"
    do
      echo "$key - ${passwords[$key]}"
    done
}

# Return password with the server parameter
get_password(){
   echo "${passwords[$1]}"
}

# Copy the argument into the clipboard
copy_clipboard(){
  echo -e '\e[93mPassword copy into the clipboard\e[0m';
  echo -ne $1 | xclip -selection clip
}

# Launch main program with all arguments
main $@
