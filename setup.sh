#!/bin/bash
OSTYPE=`uname`

install_ubuntu_apps() {
    apt-get update -y >> $HOME/bootstrap.log 2>&1 || return 1
    apt-get upgrade -y >> $HOME/bootstrap.log 2>&1 || return 1
    apt-get install -y tmux >> $HOME/bootstrap.log 2>&1 || return 1
    apt-get install -y zsh >> $HOME/bootstrap.log 2>&1 || return 1
    apt-get install -y python2.7 >> $HOME/bootstrap.log 2>&1 || return 1
    apt-get install -y vim >> $HOME/bootstrap.log 2>&1 || return 1
    apt-get install -y git >> $HOME/bootstrap.log 2>&1 || return 1
   
    # hh
    sudo add-apt-repository ppa:ultradvorka/ppa -y 
    sudo apt-get update
    sudo apt-get install hh 

    hh --show-configuration >> ~/.zshrc 
}

install_osx_apps() {
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew install hh  >> $HOME/bootstrap.log 2>&1 || return 1
    brew install wget >> $HOME/bootstrap.log 2>&1 || return 1
    brew install git >> $HOME/bootstrap.log 2>&1 || return 1
    brew install zsh >> $HOME/bootstrap.log 2>&1 || return 1

    brew install coreutils>> $HOME/bootstrap.log 2>&1 || return 1
    brew tap homebrew/dupes>> $HOME/bootstrap.log 2>&1 || return 1
    brew install binutils>> $HOME/bootstrap.log 2>&1 || return 1
    brew install diffutils>> $HOME/bootstrap.log 2>&1 || return 1
    brew install ed --with-default-names >> $HOME/bootstrap.log 2>&1 || return 1
    brew install findutils --with-default-name >> $HOME/bootstrap.log 2>&1 || return 1
    brew install gawk >> $HOME/bootstrap.log 2>&1 || return 1
    brew install gnu-indent --with-default-names >> $HOME/bootstrap.log 2>&1 || return 1
    brew install gnu-sed --with-default-names >> $HOME/bootstrap.log 2>&1 || return 1
    brew install gnu-tar --with-default-names >> $HOME/bootstrap.log 2>&1 || return 1
    brew install gnu-which --with-default-names >> $HOME/bootstrap.log 2>&1 || return 1
    brew install gnutls >> $HOME/bootstrap.log 2>&1 || return 1
    brew install grep --with-default-names >> $HOME/bootstrap.log 2>&1 || return 1
    brew install gzip >> $HOME/bootstrap.log 2>&1 || return 1
    brew install screen >> $HOME/bootstrap.log 2>&1 || return 1
    brew install watch >> $HOME/bootstrap.log 2>&1 || return 1
    brew install wdiff --with-gettext >> $HOME/bootstrap.log 2>&1 || return 1
    brew install wget >> $HOME/bootstrap.log 2>&1 || return 1
    brew install vim --override-system-vi >> $HOME/bootstrap.log 2>&1 || return 1
    brew install macvim --override-system-vim --custom-system-icons >> $HOME/bootstrap.log 2>&1 || return 1
    hh --show-zsh-configuration >> ~/.zshrc 
    
    # Install Python2.7
    brew install python@2
    curl -O https://raw.github.com/pypa/pip/master/contrib/get-pip.py
    python get-pip.py
    pip install --upgrade --force-reinstall ipython
}


if [[ $OSTYPE == 'Darwin' ]]
then
    # Mac OSX
    install_osx_apps
elif [[ $OSTYPE == 'Linux' ]]; then
    DISTRO=$(awk '/DISTRIB_ID=/' /etc/*-release | sed 's/DISTRIB_ID=//' | tr '[:upper:]' '[:lower:]')
    if [[ $DISTRO == 'ubuntu' ]]; then
        install_ubuntu_apps
    fi
elif [[ "$OSTYPE" == "cygwin" ]]; then
        # POSIX compatibility layer and Linux environment emulation for Windows
	echo "cygwin"
elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
	echo "msys"
elif [[ "$OSTYPE" == "win32" ]]; then
	echo "win32"
        # I'm not sure this can happen.
elif [[ "$OSTYPE" == "freebsd"* ]]; then
        # ...
	echo "freebsd"
else
	echo "Unknown OS"
        # Unknown.
fi

