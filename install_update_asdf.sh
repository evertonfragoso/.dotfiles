#!/usr/bin/env bash

# Add vars
. ./setup_vars.sh

if [ ! -d ~/.asdf ]; then
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  asdf install ruby ${RUBY_VERSION}
  asdf install node ${NODE_VERSION}
else
  asdf update
  asdf plugin-update --all
fi

cd $SETUP_FOLDER
