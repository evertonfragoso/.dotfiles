#!/usr/bin/env bash

# for universal-ctags - remove when is part of Homebrew repository
brew tap universal-ctags/universal-ctags

brew_list='brew_list.txt'
installed_formulae=$(brew list)

# Install formulas from list
while IFS='' read -r line || [[ -n "$line" ]]; do
  if [[ $installed_formulae != *"${line}"* ]]; then
    echo "Installing ${line}"
    brew install $line
  fi
done < $brew_list

# Upgrade all formulaes
for formulae in $installed_formulae; do
  echo -e "\033[0;46m[INFO]\033[0m ${line} already installed. Updating..."
  export HOMEBREW_INSTALL_CLEANUP="1"
  brew upgrade $formulae
done
