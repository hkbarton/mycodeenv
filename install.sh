#!/bin/sh

# Create temp folder for make
DIR=$(pwd)
LOG=$DIR"/install.log"

mkdir temp

function setupvim(){
  cd $DIR
  cp .vimrc ~/
  if [ ! -f ~/.vim/autoload/pathogen.vim ]; then
    echo "install vim pathogen (vim package manager)..."
    echo "\ninstall vim pathogen (vim package manager)..." >> $LOG
    cp -R ./.vim ~/
  fi
  # start install plugin use pathogen
  cd ~/.vim/bundle
  if [ ! -d ~/.vim/bundle/nerdtree ]; then
    echo "install nerdtree..."
    echo "\ninstall nerdtree..." >> $LOG
    git clone https://github.com/scrooloose/nerdtree.git >> $LOG 2>&1
  fi
  if [ ! -d ~/.vim/bundle/syntastic ]; then
    echo "install syntastic..."
    echo "\ninstall syntastic..." >> $LOG
    git clone https://github.com/scrooloose/syntastic.git >> $LOG 2>&1
  fi
  if [ ! -d ~/.vim/bundle/vim-colors-solarized ]; then
    echo "install vim-colors-solarized..."
    echo "\ninstall vim-colors-solarized..." >> $LOG
    git clone https://github.com/altercation/vim-colors-solarized.git >> $LOG 2>&1
  fi
  if [ ! -d ~/.vim/bundle/vim-commentary ]; then
    echo "install vim-commentary..."
    echo "\ninstall vim-commentary..." >> $LOG
    git clone https://github.com/tpope/vim-commentary.git >> $LOG 2>&1
  fi
  if [ ! -d ~/.vim/bundle/vim-powerline ]; then
    echo "install vim-powerline..."
    echo "\ninstall vim-powerline..." >> $LOG
    git clone https://github.com/Lokaltog/vim-powerline.git >> $LOG 2>&1
  fi
  if [ ! -d ~/.vim/bundle/YouCompleteMe ]; then
    echo "install YouCompleteMe..."
    echo "\ninstall YouCompleteMe..." >> $LOG
    git clone https://github.com/Valloric/YouCompleteMe.git >> $LOG 2>&1
    echo "post compiling YouCompleteMe..."
    echo "\npost compiling YouCompleteMe..." >> $LOG
    cd YouCompleteMe
    git submodule update --init --recursive >> $LOG 2>&1
    ./install.sh --clang-completer >> $LOG 2>&1
    if [ $? -ne 0 ]; then
      echo "post compiling YouCompleteMe failed, check log file."
    fi
  fi
  cd $DIR
  echo "Done! Happy Hacking!"
}

function imac(){
  # in mac install xcode will install common develop library we need later
  echo "### make sure you have the latest Xcode installed ###"
  # Install MacVim
  MacVimRepo="https://github.com/b4winckler/macvim.git"
  HasMacVim=1
  hashmvim=$(hash mvim 2>&1)
  if [ ! -z "$hashmvim" ]; then
    echo "### need install MacVim first ###"
    cd temp
    echo "cloneing source code of MacVim......" 
    echo "cloneing source code of MacVim......" >> $LOG
    git clone $MacVimRepo >> $LOG 2>&1
    cd macvim
    echo "configuring MacVim......."
    echo "\nconfiguring MacVim......." >> $LOG
    ./configure --with-features=huge \
                --enable-multibyte \
                --enable-rubyinterp=yes \
                --enable-perlinterp=yes \
                --enable-luainterp=yes \
                --enable-pythoninterp=yes \
                --with-python-config-dir=/usr/lib/python2.7/config >> $LOG 2>&1
    if [ $? -eq 0 ]; then
      echo "make MacVim......"
      echo "\nmake MacVim......" >> $LOG
      make >> $LOG 2>&1
      if [ $? -eq 0 ]; then
        cp -R src/MacVim/build/Release/MacVim.app /Applications/
        cd $DIR
        # need run using sudo
        sudo cp mac/mvim /usr/bin
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
  if [ $HasMacVim -eq 0 ]; then
    setupvim
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
