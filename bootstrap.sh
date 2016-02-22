#!/usr/bin/env bash
#
# bootstrap installs things.

cd "$(dirname "$0")"
DOTFILES_ROOT="$(pwd -P)/.."

set -e

echo ''

info () {
  printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user () {
  printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success () {
  printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail () {
  printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
  echo ''
  exit
}

print_result () {
  [ $1 -eq 0 ] \
      && sucess "$2" \
          || fail "$2"

  [ "$3" == "true" ] && [ $1 -ne 0 ] \
      && exit
}

link_file () {
  local src=$1 dst=$2

  local overwrite= backup= skip=
  local action=

  if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]
  then

    if [ "$overwrite_all" == "false" ] && [ "$backup_all" == "false" ] && [ "$skip_all" == "false" ]
    then

      local currentSrc="$(readlink $dst)"

      if [ "$currentSrc" == "$src" ]
      then

        skip=true;

      else

        user "File already exists: $dst ($(basename "$src")), what do you want to do?\n\
        [s]kip, [S]kip all, [o]verwrite, [O]verwrite all, [b]ackup, [B]ackup all?"
        read -n 1 action

        case "$action" in
          o )
            overwrite=true;;
          O )
            overwrite_all=true;;
          b )
            backup=true;;
          B )
            backup_all=true;;
          s )
            skip=true;;
          S )
            skip_all=true;;
          * )
            ;;
        esac

      fi

    fi

    overwrite=${overwrite:-$overwrite_all}
    backup=${backup:-$backup_all}
    skip=${skip:-$skip_all}

    if [ "$overwrite" == "true" ]
    then
      rm -rf "$dst"
      success "removed $dst"
    fi

    if [ "$backup" == "true" ]
    then
      mv "$dst" "${dst}.backup"
      success "moved $dst to ${dst}.backup"
    fi

    if [ "$skip" == "true" ]
    then
      success "skipped $src"
    fi
  fi

  if [ "$skip" != "true" ]  # "false" or empty
  then
    ln -s "$1" "$2"
    success "linked $1 to $2"
  fi
}

setup_xcode () {
  if ! xcode-select --print-path &> /dev/null; then
    # Prompt user to install the XCode Command Line Tools
    xcode-select --install &> /dev/null

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait until the XCode Command Line Tools are installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done

    print_result $? 'Install XCode Command Line Tools'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Point the `xcode-select` developer directory to
    # the appropriate directory from within `Xcode.app`
    # https://github.com/alrra/dotfiles/issues/13

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
    print_result $? 'Make "xcode-select" developer directory point to Xcode'

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Prompt user to agree to the terms of the Xcode license
    # https://github.com/alrra/dotfiles/issues/10

    sudo xcodebuild -license
    print_result $? 'Agree with the XCode Command Line Tools licence'
  fi
}

setup_gitconfig () {
  if ! [ -f git/gitconfig.symlink ]
  then
    info 'setup gitconfig'

    credential='cache'
    if [ "$(uname -s)" == "Darwin" ]
    then
      credential='osxkeychain'
    fi

    user ' - What is your github author name?'
    read -e authorname
    user ' - What is your github author email?'
    read -e authoremail
    user ' - What is your github author editor?'
    read -e editor

    sed -e "s/AUTHORNAME/$authorname/g" -e "s/AUTHOREMAIL/$authoremail/g" -e "s/CREDENTIAL_HELPER/$credential/g" -e "s/EDITOR/$editor/g" gitconfig.symlink.example > gitconfig.symlink

    echo 'allow to use ssh with github'
    ssh-keygen -t rsa -b 4096 -C $authoremail
    ssh-add ~/.ssh/id_rsa
    pbcopy < ~/.ssh/id_rsa.pub

    echo 'public key is in clipboard, add ssh key to github'
    open https://github.com/settings/ssh

    echo 'generate token if you prefer to use https'
    open https://github.com/settings/tokens

    success 'gitconfig'
  fi
}

install_dotfiles () {
  info 'installing dotfiles'

  local overwrite_all=false backup_all=false skip_all=false

  for src in $(find -H "$DOTFILES_ROOT" -maxdepth 2 -name '*.symlink')
  do
    dst="$HOME/.$(basename "${src%.*}")"
    link_file "$src" "$dst"
  done
}

install_spaceemacs () {
  git clone https://github.com/syl20bnr/spacemacs ~/.emacs.d
  tic -o ~/.terminfo eterm-color.ti # fix emacs color terminal with zsh
}

install_apps () {
  #
  # Homebrew
  #
  # This installs some of the common dependencies needed (or at least desired)
  # using Homebrew.

  # Check for Homebrew
  if test ! $(which brew)
  then
    echo "  Installing Homebrew for you."

    # Install the correct homebrew for each OS type
    if test "$(uname)" = "Darwin"
    then
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    elif test "$(expr substr $(uname -s) 1 5)" = "Linux"
    then
      ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/linuxbrew/go/install)"
    fi
  else
    #statements
    # Make sure we’re using the latest Homebrew
    brew update

    # Upgrade any already-installed formulae
    brew upgrade
  fi

  # Install native apps
  brew install caskroom/cask/brew-cask
  brew tap caskroom/versions

  # daily
  brew cask install amethyst
  brew cask install alfred
  brew cask install dropbox
  brew cask install skype

  # dev

  # emacs
  brew tap railwaycat/emacsmacport
  brew cask install emacs-mac
  brew install emacs
  brew linkapps emacs
  # vim
  brew tap neovim/neovim
  brew install --HEAD neovim
  brew install vim

  brew cask install iterm2
  brew cask install virtualbox
  brew cask install sublime-text
  brew cask install imagealpha
  brew cask install imageoptim
  brew cask install sourcetree

  # browsers
  brew cask install google
  brew cask install google-chrome-canary
  brew cask install firefoxdeveloperedition
  brew cask install firefox
  brew cask install torbrowser

  # fun
  brew cask install vlc
  brew cask install spotify
  brew cask install kindle
  brew cask install steam
  brew tap caskroom/fonts
  brew cask install font-hack

  # Install homebrew packages

  # GNU core utilities (those that come with OS X are outdated)
  # Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
  brew install coreutils
  # brew install moreutils
  # GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed
  brew install findutils
  # GNU `sed`, overwriting the built-in `sed`
  brew install gnu-sed --with-default-names

  # utils
  # Install wget with IRI support
  brew install wget --enable-iri
  brew install jq
  brew install zsh

  # install prezto
  git clone --recursive https://github.com/Fetz/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  # run this
  # setopt EXTENDED_GLOB
  # for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
  #   ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
  # done
  brew install tree
  brew install todo-txt
  
  # install tmux
  brew install tmux
  curl -OL https://raw.github.com/richo/battery/master/bin/battery; mkdir -p bin/; mv battery bin/battery; chmod +x bin/battery;
  
  # install improve search
  brew install the_platinum_searcher
  brew install the_silver_searcher

  # install nice to have
  brew install python
  brew install python3
  brew install lua
  
  # install nodejs
  brew install nvm
  export NVM_DIR=~/.nvm
  . $(brew --prefix nvm)/nvm.sh
  nvm install node
  
  # Install clojure
  brew cask install java
  brew install leiningen
  # curl -L http://smartcd.org/install | bash

  # Remove outdated versions from the cellar
  brew cleanup

}

set_zsh () {
  echo 'change default shell to zsh'
  chsh -s /bin/zsh
}

setup_xcode
setup_gitconfig
install_apps
install_dotfiles
install_spaceemacs
set_zsh
