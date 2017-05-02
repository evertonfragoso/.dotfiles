source ~/.profile

# Vim is default editor
export EDITOR="vim"

# Report terminal type
export TERM=xterm-256color

alias v=$EDITOR

# bash ls aliases
export LS_COLORS=Exfxcxdxbxegedabagacad
alias l="ls -l -G $@"
alias la="l -a $@"

# brew aliases
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
alias gl="g pull"
alias gp="g push"
alias gs="g status"
alias gc="g commit -m $1"
alias gco="g checkout"

# Bundler aliases
alias b="bundle"
alias be="b exec"
alias bi="b install"
alias bu="b update"

# Rails aliases
alias br="be rails"
alias brake="be rake"
alias mig="brake db:migrate"
alias spec="be rspec $1"

# PG aliases
alias pg="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log $1"

# MySQL aliases
alias mysql="mysql.server $1"

# flush DNS
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# thefuck
eval "$(thefuck --alias)"

