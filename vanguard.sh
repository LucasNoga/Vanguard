#!/bin/bash

# ------------------------------------------------------------------
# [Author] : Lucas Noga
# [Title] : Password Handler
# [Description] : Password manager to get your password in your clipboard
# [Version] : 1.1
# [Usage] : pass <key_password>"
# ------------------------------------------------------------------
# TODO Faire un script windows et un script linux ou bien fusionner les deux
VERSION=1.0.2
USAGE="Usage: pass <key_password>"

main() {

  if [ $# = 0 ]; then
    get_all_passwords
  else
    copy_password $@
  fi
}

get_options() {
  # TODO: pour le getopts https://www.quennec.fr/book/export/html/341
  # faire une method check option dans le main

  while getopts "abcd:e:" option; do
    echo "getopts a trouvé l'option $option"
    case $option in
    a)
      echo "Exécution des commandes de l'option a"
      echo "Indice de la prochaine option à traiter : $OPTIND"
      ;;
    b)
      echo "Exécution des commandes de l'option b"
      echo "Indice de la prochaine option à traiter : $OPTIND"
      ;;

    \
      c)
      echo "Exécution des commandes de l'option c"
      echo "Indice de la prochaine option à traiter : $OPTIND"
      ;;
    d)
      echo "Exécution des commandes de l'option d"
      echo "Liste des arguments à traiter : $OPTARG"
      echo "Indice de la prochaine option à traiter : $OPTIND"
      ;;
    e)
      echo "Exécution des commandes de l'option e"
      echo "Liste des arguments à traiter : $OPTARG"
      echo "Indice de la prochaine option à traiter : $OPTIND"
      ;;
    esac
  done
  echo "Analyse des options terminée"
  exit 0
}

# Method which copy the password asked by the user in his cliboard
copy_password() {
  SERVER=$1
  password=$(get_password $SERVER)

  # Copy the password if existing
  if [ -z "$password" ]; then
    echo -e '\e[91m\e[1mPassword Unknown\e[0m'
  else
    copy_clipboard $password
    echo -e '\e[93mPassword copy into the clipboard\e[0m'
    exit 0
  fi
}

# List all password added
get_all_passwords() {
  for key in "${!passwords[@]}"; do
    echo "$key - ${passwords[$key]}"
  done
}

# Copy the argument into the clipboard detect which os
copy_clipboard() {
  OS=$(detect_os)
  case $OS in
  "Linux") echo -ne $1 | xclip -selection clip ;;
  "Windows") echo -ne $1 | clip.exe ;;
  *) echo nothing ;;
  esac
}

# Determine how to copy on cliboard
detect_os() {
  os_linux=$(is_linux_os)
  os_windows=$(is_windows_os)
  if [ $os_linux = 0 ]; then
    echo "Linux"
  elif [ $os_windows = 0 ]; then
    echo "Windows"
  fi
}

# Run clipboard command linux to know if the command works
is_linux_os() {
  echo -ne $1 | xclip -selection clip 2>/dev/null
  echo $?
}

# Run clipboard command windows to know if the command works
is_windows_os() {
  echo -ne $1 | clip.exe 2>/dev/null
  echo $?
}

# Return password with the server parameter
get_password() {
  echo "${passwords[$1]}"
}

#
#       HERE YOU CAN STORE YOUR PASSWORDS
#
# HASHMAP for password list
declare -A passwords=(
  ["id1"]=$'password1'
  ["id2"]=$'password2'
  ["id3"]=$'password3'
)

# Launch main program with all arguments
main $@
