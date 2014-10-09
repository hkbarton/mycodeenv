#!/bin/sh
# Vim Plugin need installed
# 1. nerdtree
# 2. syntastic
# 3. vim-colors-solarized
# 4. vim-commentary
# 5. vim-powerline
# 6. YouCompleteMe note: need run "git submodule update --init --recursive" to fetch 3rd lib

# Create temp folder for make
mkdir temp

function imac(){
  MacVimRepo="https://github.com/b4winckler/macvim.git"
  if [ ! -z `hash mvim` ]; then
    echo "Need install MacVim first"
    cd temp
    git clone $MacVimRepo
    cd macvim
    ./configure --with-features=big
    make
    cp MacVim/build/Release/MacVim.app /Applications/
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
    
