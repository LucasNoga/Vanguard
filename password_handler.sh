#!/bin/bash

# ------------------------------------------------------------------
# [Author] : Lucas Noga
# [Title] : Password Handler
# [Description] : Password manager to get your password in your clipboard
# [Version] : 1.1
# [Usage] : pass <key_password>"
# ------------------------------------------------------------------

VERSION=1.0.2
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
      echo -e '\e[91m\e[1mPassword Unknown\e[0m'
    else
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

# Copy the argument into the clipboard detect which os
copy_clipboard(){
  OS=$(detect_os)
  case $OS in
    "Linux") echo -ne $1 | xclip -selection clip;;
    "Windows") echo -ne $1 | clip.exe;;
    *) echo nothing;;
  esac
}

# Return password with the server parameter
get_password(){
   echo "${passwords[$1]}";
}

# determine how to copy on cliboard
detect_os(){
  os_linux=$(is_linux_os)
  os_windows=$(is_windows_os)
  if [ $os_linux = 0 ]
  then
    echo "Linux"
  elif [ $os_windows = 0 ]
  then
    echo "Windows"
  fi
}

# Run clipboard command linux to know if the command works
is_linux_os(){
  echo -ne $1 | xclip -selection clip 2> /dev/null;
  echo $?
}

# Run clipboard command windows to know if the command works
is_windows_os(){
  echo -ne $1 | clip.exe 2> /dev/null;
  echo $?
}

# Launch main program with all arguments
main $@
