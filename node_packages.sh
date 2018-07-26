#!/bin/bash

npm_list='node_packages.txt'
while IFS='' read -r line || [[ -n "$line" ]]; do
  echo "Installing ${line}"
  npm install -g ${line}
done < "$npm_list"
