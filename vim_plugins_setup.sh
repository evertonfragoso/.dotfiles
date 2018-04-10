#!/bin/bash

# Add vars
. ./setup_vars.sh

# list of plugins to install
nvim_plugins="$VIM_FOLDER/plugins.txt"

while IFS='' read -r line || [[ -n "$line" ]]; do
  IFS='/' read -ra plugin_user_repo <<< "$line"
  plugin_name="${plugin_user_repo[1]}"
  if [ ! -d "$bundle_folder/$plugin_name" ]; then
    echo "Cloning $line"
    cd $bundle_folder && git clone https://github.com/$line
  else
    echo -e "\033[0;46m[INFO]\033[0m $plugin_name already exists. Updating..."
    cd $bundle_folder/$plugin_name && git pull
  fi
done < "$nvim_plugins"
