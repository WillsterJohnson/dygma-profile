#!/usr/bin/env bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

function __get_newest_file() { echo $(ls -Art "$1" | tail -n 1); }

pushd $SCRIPT_DIR > /dev/null
git reset --hard HEAD
git pull
dygmaHome="$HOME/Dygma/Backups"
keyboard=$(__get_newest_file "$dygmaHome")
neuron=$(__get_newest_file "$dygmaHome/$keyboard")
keymap=$(__get_newest_file "$dygmaHome/$keyboard/$neuron")
cp "$dygmaHome/$keyboard/$neuron/$keymap" "./backup.json"
git add .
git commit -m "Update backup.json ($keyboard - $neuron - $keymap)"
git push
popd > /dev/null
