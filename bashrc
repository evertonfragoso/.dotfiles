#!/bin/bash
source ~/.profile

# Format Bash prompt
source ~/.git-prompt

# Vim is default editor
export EDITOR="nvim"
# Report terminal type
#export TERM=xterm-256color

# Bat color for light background terminal
export BAT_THEME=GitHub

alias v=$EDITOR
alias vi=$EDITOR
alias vim=$EDITOR

# bash ls aliases
export LS_COLORS=Exfxcxdxbxegedabagacad
alias l="ls -lG $@"
alias la="l -A $@"

# z navigator
. $HOME/z/z.sh

# Make directory and change into it.
mcd() {
  mkdir -p $1 && cd $1
}

# Homebrew
cleanup() {
  brew update
  brew upgrade $(brew list)
  brew cleanup

  cache_folder=~/Library/Caches/Homebrew
  for i in $(ls $cache_folder); do
    rm "${cache_folder}/${i}"
  done
}

# git aliases
alias g="git"
alias ga="g add"
alias pull="g pull"
alias push="g push"
alias push1="push -u origin HEAD"
alias gs="g status"
alias gco="g checkout"
commit() {
  message=$1
  git commit -m "$(echo -e "$message")"
}
clone() {
  if [ -n $1 ] ; then
    if [[ $1 =~ ^https?|git@ ]]; then
      echo "Cloning ${1}";
      git clone $1
    elif [[ $1 =~ ^[0-9a-zA-Z._-]+\/[0-9a-zA-Z._-]+$ ]]; then
      echo "Cloning git@github.com:${1}.git";
      git clone git@github.com:$1.git
    else
      echo 'Urecognized repository name'
    fi
  else
    echo 'Repository URL needed.';
    echo 'Usage:';
    echo '  - clone http://github.com/UserName/Repo.git';
    echo '  - clone UserName/Repo';
    echo '    Attention: this format uses github to clone'
  fi
}

# Travis (and some more in the future)
travis() {
  open "https://travis-ci.com/$(git remote get-url origin | grep -oE "[^\/:]\w+/[^\.]+")"
}

# Bundler aliases
alias b='bundle'
alias be='b exec'
alias bi='b install'
alias bu='b update'

# Rails aliases
alias br='be rails'
alias brake='be rake'
alias mig='brake db:migrate'
alias spec='be rspec'

# node aliases
alias n='node'
# Use pnpm as default package manager
alias np='pnpm'

# docker containers
dckr() {
  if [ -z $1 ]; then
    echo "What command? (e.g. 'console' for rails console, 'psql' for psql, etc)"
    return
  fi

  containers=$(docker ps --format "{{.Names}}" | tr "\n" ",")
  choice=''

  IFS="," read -r -a containers_list <<< "$containers"
  echo "Containers:"
  for index in "${!containers_list[@]}"; do
    echo -e "  [$index] ${containers_list[index]}"
  done

  while [ -z $choice ]; do
    echo -n "Enter the container number and press [ENTER]: "
    read choice
  done

  if [ $choice -gt ${#containers_list[@]} ]; then
    echo "Invalid option"
    return
  fi

  case $1 in
    "console")
      docker exec -it ${containers_list[choice]} bundle exec rails console
      ;;
    "psql")
      docker exec -it ${containers_list[choice]} psql -U postgres
      ;;
    *)
      docker exec -it ${containers_list[choice]} $*
      ;;
  esac
}

# Tmux aliases
#alias tmux='tmux -2'
#alias ta='tmux attach -t'
#alias tnew='tmux new -s'
#alias tls='tmux ls'
#alias tkill='tmux kill-session -t'

# If using tmux, attach tmux session on start
#if [[ $TMUX = "" ]]; then
#  tmux ls | grep -vq attached && TMUXARG="attach-session -d"
#  tmux $TMUXARG
#fi

# PG aliases
alias pg="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log"

# MySQL aliases
alias mysql="mysql.server"

# flush DNS
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# thefuck
eval "$(thefuck --alias)"
