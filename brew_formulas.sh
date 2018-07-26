#!/bin/bash

# for universal-ctags - remove when is part of Homebrew repository
brew tap universal-ctags/universal-ctags

brew_list='brew_list.txt'
installed_formulae=$(brew list)
while IFS='' read -r line || [[ -n "$line" ]]; do
  if [[ installed_formulae == *"${line}"* ]]; then
    echo "Installing ${line}"
    brew install ${line}
  else
    echo -e "\033[0;46m[INFO]\033[0m ${line} already installed. Updating..."
    brew upgrade ${line} --cleanup
  fi
done < "$brew_list"
