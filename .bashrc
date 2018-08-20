#!/bin/bash
source ~/.profile

# Format Bash prompt
source ~/.git-prompt

# Vim is default editor
export EDITOR="nvim"
# Report terminal type
#export TERM=xterm-256color

alias v=$EDITOR
alias vi=$EDITOR
alias vim=$EDITOR

# bash ls aliases
export LS_COLORS=Exfxcxdxbxegedabagacad
alias l="ls -l -G $@"
alias la="l -a $@"

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
alias gs="g status"
alias commit="g commit -m"
alias gco="g checkout"
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
