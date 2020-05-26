#!/bin/sh                                                                                    
                                                                                             
CORES=$(nproc || echo 1)                                                                     
                                                                                             
export CFLAGS="-O3 -pipe -march=native"                                                      
export CXXFLAGS=$CFLAGS                                                                      
export MAKEFLAGS="-j$CORES"                                                                  
export SAMUFLAGS=$MAKEFLAGS                                                                  

# export KISS_PROMPT=0  # disable prompts (for scripting)
export KISS_PATH_MAIN=/var/db/kiss/repo/core:/var/db/kiss/repo/extra:/var/db/kiss/repo/xorg
export KISS_PATH_COMMUNITY=/var/db/kiss/community/community
export KISS_PATH_PERSONAL=/home/mc/proj/mcpcpc-repo
export KISS_PATH="$KISS_PATH_PERSONAL:$KISS_PATH_MAIN:$KISS_PATH_COMMUNITY"
                                                                                             
export XDG_DATA_HOME=/home/mc/.sx                                                            
export XDG_CONFIG_HOME=$XDG_DATA_HOME                                                        
                                                                                             
export ENV=$HOME/.shrc                                                                       
                                                                                             
export EDITOR="vim"                                                                          
export VISUAL="$EDITOR"                                                                      
export TERMINAL="st"                                                                         
export BROWSER="surf"
