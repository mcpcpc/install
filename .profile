#!/bin/sh                                                                                    
          
# flags
CORES=$(nproc || echo 1)                                                                     
export CFLAGS="-O3 -pipe -march=native"                                                      
export CXXFLAGS=$CFLAGS                                                                      
export MAKEFLAGS="-j$CORES"                                                                  
export SAMUFLAGS=$MAKEFLAGS                                                                  

# kiss
export KISS_PROMPT=1  # 0 to disable prompts (for scripting)
export KISS_PATH="$KISS_PATH:/home/mc/community/community"

# sx
export XDG_DATA_HOME=/home/mc/.sx                                                            
export XDG_CONFIG_HOME=$XDG_DATA_HOME                                                        
                                                                                  
export ENV="$HOME/.shrc"                                                               

# defaults
export EDITOR="vim"                                                                          
export VISUAL=$EDITOR                                                                      
export TERMINAL="st"                                                                         
export BROWSER="surf"
