#!/bin/sh
# Vim Plugin need installed
# 1. nerdtree
# 2. syntastic
# 3. vim-colors-solarized
# 4. vim-commentary
# 5. vim-powerline
# 6. YouCompleteMe note: need run "git submodule update --init --recursive" to fetch 3rd lib

# Create temp folder for make
LOG="install.log"

mkdir temp

function imac(){
  # Install MacVim
  MacVimRepo="https://github.com/b4winckler/macvim.git"
  HasMacVim=1
  if [ ! -z `hash mvim` ]; then
    echo "### need install MacVim first ###"
    cd temp
    echo "cloneing source code of MacVim......" 
    echo "cloneing source code of MacVim......" > $LOG
    git clone $MacVimRepo > $LOG 2>1
    cd macvim
    echo "configuring MacVim......."
    echo "\nconfiguring MacVim......." > $LOG
    ./configure --with-features=huge > $LOG 2>1
    if [ $? -eq 0 ]; then
      echo "make MacVim......"
      echo "\nmake MacVim......" > $LOG
      make > $LOG 2>1
      if [ $? -eq 0 ]; then
        cp src/MacVim/build/Release/MacVim.app /Applications/
        cp ../../
        # need run using sudo
        cp mac/mvim /usr/bin
        echo "alias vi='mvim'" >> ~/.bash_profile
        echo "alias vim='mvim'" >> ~/.bash_profile
        HasMacVim=0
        echo "### successful install MacVim ###"
      else
        echo "make MacVim failed, check log file"
      fi
    else
      echo "configure MacVim failed, check log file"
    fi
  else
    HasMacVim=0
  fi

  # Instal VIM Plugin
  if [ HasMacVim -eq 0 ]; then
    echo "Install vim plugin"
  fi
}

function ilinux(){
  echo "install for linux"
}

case `uname` in
  Darwin)
    imac
    ;;
  Linux)
    ilinux
    ;;
  *)
    echo "Unknown OS Type"
    ;;
esac

# Delete temp folder
rm -rf temp
    
