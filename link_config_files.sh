#!/usr/bin/env bash

# Add vars
. ./setup_vars.sh

# list of files to link
config_files='config_files.txt'

while IFS='' read -r line || [[ -n "$line" ]]; do
  filename=".${line}"
  echo "Creating link for $filename"
  # remove the existing link or file
  rm -f ~/$filename
  # create new link
  ln -s $SETUP_FOLDER/$line ~/$filename
done < "$config_files"
