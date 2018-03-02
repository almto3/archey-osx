#!/bin/bash

clear
clear
clear
archey -c

noUpdates=0
needsUpdates=0
clean="nothing to commit, working tree clean"
OLDIFS="$IFS"

for dir in ~/Git/*
do
  cd "$dir"

  stat=$(git status)
  if [[ "$stat" = *"$clean"* ]]; then
    noUpdates=$((noUpdates + 1))
  else
    needsUpdates=$((needsUpdates + 1))

    workingDir=$(pwd)
    if [[ $workingDir =~ \/([^\/]*)$ ]]; then
      echo -e '\033[31m \t' ${BASH_REMATCH[1]}
    fi

    IFS=$'\n'; arr=($stat)
    A="$(cut -d' ' -f1 <<<"${arr[0]}")"
    B="$(cut -d' ' -f2 <<<"${arr[0]}")"
    C="$(cut -d' ' -f3 <<<"${arr[0]}")"
    echo -e '\t' "\033[96m$A $B \033[95m$C"
    echo -e '\t' "\033[96m${arr[2]}"
    arrayLength=${#arr[*]}
    for (( i=4; i<${arrayLength}-1; i++ )); do
      if [[ ! "${arr[$i]}" =~ ^[[:space:]]*"(" ]]; then
        echo -e '\t' "\033[96m${arr[$i]}"
      fi
    done
    echo -e '\n'
  fi
done

echo -e '\n' '\t' "\033[35m ;; "$noUpdates repos clean ";;" $needsUpdates need commitin ";;\033[37m"
IFS="$OLDIFS"
