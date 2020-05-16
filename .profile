#!/bin/sh

CORES=$(nproc || echo 1)

export CFLAGS="-O3 -pipe -march=native"
export CXXFLAGS=$CFLAGS
export MAKEFLAGS="-j$CORES"
export SAMUFLAGS=$MAKEFLAGS

alias ll="ls -al"
alias vi=vim
alias ..="cd .."

paste () {
	curl -sF 'clbin=<'"${1:--}" https://clbin.com;
}
