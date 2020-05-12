#!/bin/sh
CORES=$(nproc || echo 1)

export CFLAGS="-O3 -pipe -march=native"
export CXXFLAGS=$CFLAGS
export MAKEFLAGS="-j$CORES"
export SAMUFLAGS=$MAKEFLAGS
