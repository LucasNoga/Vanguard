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
    echo Aucun argument recu !
    echo -e 'Monit:' $(get_password 'monit')
    echo -e '\nEU:'
    echo -e '   -  eu1.cruxpool.com:' $(get_password 'eu1')
    echo -e '   -  eu2.cruxpool.com:' $(get_password 'eu2')
    echo -e '\nUS:'
    echo -e '   -  us.cruxpool.com:' $(get_password 'us')
    echo -e '\nASIA:'
    echo -e '   -  asia.cruxpool.com: '$(get_password 'asia')
    echo -e '\nnode:'
    echo -e '   -  node1: '$(get_password 'node1')
    echo -e '   -  node2: '$(get_password 'node2')
    echo -e '\ncloud:'
    echo -e '   -  db1:' $(get_password 'db1')
    echo -e '   -  payout2:' $(get_password 'payout2')
    echo -e '\nbeta:' $(get_password 'beta')
    echo

else
    SERVER=$1
    CLOUD_INSTANCE=$2

    # si c'est un mot de passe de cloud on recupere l'instance au lieu du serveur
    if [ "$SERVER" = "cloud" ]
    then
        password=$(get_password $CLOUD_INSTANCE)
    else
        password=$(get_password $SERVER)
    fi

    if [ "$password" = "no password" ]
    then
        echo -e '\e[91m\e[1mPassword Unknown\e[0m'
        exit 1
    fi

    # Copy the password
    copy_clipboard $password
    #echo -e '\e[93mPassword copy into the clipboard\e[0m';
    #echo -ne $PASSWORD | xclip -selection clip
fi
}

# HASHMAP for password list
declare -A passwords=(
    ["id1"]=$'password1'
    ["id2"]=$'password2'
    ["id3"]=$'password3'
)

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