#!/bin/sh                                                                                    
                                                                                             
CORES=$(nproc || echo 1)                                                                     
                                                                                             
export CFLAGS="-O3 -pipe -march=native"                                                      
export CXXFLAGS=$CFLAGS                                                                      
export MAKEFLAGS="-j$CORES"                                                                  
export SAMUFLAGS=$MAKEFLAGS                                                                  
                                                                                             
export XDG_DATA_HOME=/home/mc/.sx                                                
export XDG_CONFIG_HOME=$XDG_DATA_HOME                                                        

export KISS_PATH=/var/db/kiss/repo/core:/var/db/kiss/repo/extra:/var/db/kiss/repo/xorg:/var/db/kiss/community/community
export ENV=$HOME/.shrc                                                                       
                                                                                             
export EDITOR="vim"                                                                          
export VISUAL="$EDITOR"                                                                      
export TERMINAL="st"
