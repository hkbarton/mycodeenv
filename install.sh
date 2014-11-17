#!/bin/sh

# Create temp folder for make
DIR=$(pwd)
LOG=$DIR"/install.log"

mkdir temp

function setupvim(){
  cd $DIR
  cp .vimrc ~/
  cp -R ./.vim ~/

# install NeoBundle
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh | sh >> $LOG 2>&1

### Since I start use NeoBundle to mange some of my plugins, I don't need rely on pathogen now

  # start install plugin use pathogen
# if [ ! -f ~/.vim/autoload/pathogen.vim ]; then
#   echo "install vim pathogen (vim package manager)..."
#   echo "\ninstall vim pathogen (vim package manager)..." >> $LOG
#   cp -R ./.vim ~/
# fi
  cd ~/.vim/bundle
  # NERDTree
# if [ ! -d ~/.vim/bundle/nerdtree ]; then
#    echo "install nerdtree..."
#    echo "\ninstall nerdtree..." >> $LOG
#    git clone https://github.com/scrooloose/nerdtree.git >> $LOG 2>&1
#  fi
  # syntastic
#  if [ ! -d ~/.vim/bundle/syntastic ]; then
#    echo "install syntastic..."
#    echo "\ninstall syntastic..." >> $LOG
#    git clone https://github.com/scrooloose/syntastic.git >> $LOG 2>&1
#  fi
  # color theme - solarized
#  if [ ! -d ~/.vim/bundle/vim-colors-solarized ]; then
#    echo "install vim-colors-solarized..."
#    echo "\ninstall vim-colors-solarized..." >> $LOG
#    git clone https://github.com/altercation/vim-colors-solarized.git >> $LOG 2>&1
#  fi
  # comment plugin
#  if [ ! -d ~/.vim/bundle/vim-commentary ]; then
#    echo "install vim-commentary..."
#    echo "\ninstall vim-commentary..." >> $LOG
#    git clone https://github.com/tpope/vim-commentary.git >> $LOG 2>&1
#  fi
  # power line
#  if [ ! -d ~/.vim/bundle/vim-powerline ]; then
#    echo "install vim-powerline..."
#    echo "\ninstall vim-powerline..." >> $LOG
#    git clone https://github.com/Lokaltog/vim-powerline.git >> $LOG 2>&1
#  fi
  # ctrlp.vim file name search plugin
#  if [ ! -d ~/.vim/bundle/ctrlp.vim ]; then
#    echo "install ctrlp.vim..."
#    echo "\ninstall ctrlp.vim..." >> $LOG
#    git clone https://github.com/kien/ctrlp.vim.git >> $LOG 2>&1
#  fi

### I still install YouCompleteMe manully, because this plugin require pre-compile action

  # YouCompleteMe
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
  hasclt=$(pkgutil --pkg-info=com.apple.pkg.CLTools_Executables 2>&1 | grep version)
  if [ -z "$hasclt" ]; then
    echo "no xcode command line tool found, need install first"
    echo "installing xcode command line tool..."
    echo "\ninstalling xcode command line tool..." >> $LOG
    xcode-select --install >> $LOG 2>&1
    if [ $? -ne 0 ]; then
      echo "failed install xcode command line tool, check log"
      echo "MAKE SURE you have latest version of xcode installed"
      return 1
    fi
    echo "please run this script again after you finish install xcode command line tool"
    echo "\nplease run this script again after you finish install xcode command line tool" >> $LOG
    return 0
  fi
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
