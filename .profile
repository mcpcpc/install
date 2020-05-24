#!/bin/sh

CORES=$(nproc || echo 1)

export CFLAGS="-O3 -pipe -march=native"
export CXXFLAGS=$CFLAGS
export MAKEFLAGS="-j$CORES"
export SAMUFLAGS=$MAKEFLAGS

export XDG_DATA_HOME="/home/mc/.sx"
export XDG_CONFIG_HOME=$XDG_DATA_HOME

alias ll="ls -al"
alias vi=vim
alias ..="cd .."

paste () {
	curl -sF 'clbin=<'"${1:--}" https://clbin.com;
}
