#!/usr/bin/env bash
#
# bootstrap installs things.

# heavily inspired (copy pasted) https://github.com/holman/dotfiles/blob/master/script/bootstrap

cd "$(dirname "$0")"
DOTFILES_ROOT="$(pwd -P)/.."

set -e

echo ''

pause(){
  read -n1 -rsp $'Press any key to continue or Ctrl+C to exit...\n'
}

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

git_clone() {
    REPOSRC=$1
    LOCALREPO=$2

    # We do it this way so that we can abstract if from just git later on
    LOCALREPO_VC_DIR=$LOCALREPO/.git

    if [ ! -d $LOCALREPO_VC_DIR ]
    then
        git clone --recursive $REPOSRC $LOCALREPO
    else
        cd $LOCALREPO
        git pull $REPOSRC
    fi
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

    else

      skip=true;

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

setup_gitconfig () {
  if ! [ -f git/gitconfig.symlink ]
  then
    info 'setup gitconfig'

    credential='cache'
    if [ "$(uname -s)" == "Darwin" ]
    then
      credential='osxkeychain'
    fi

    user ' - What is your personal git author name?'
    read -e authorname_personal
    user ' - What is your personal git author email?'
    read -e authoremail_personal
    user ' - Do you want to verify your personal git commits?'
    read -e use_gpg_personal
    user ' - What is your work git author name?'
    read -e authorname_work
    user ' - What is your work git author email?'
    read -e authoremail_work
    user ' - Do you want to verify your work git commits?'
    read -e use_gpg_work
    user ' - What is your git editor?'
    read -e editor

    info 'allow to use ssh with github'
    ssh-keygen -t rsa -b 4096 -C $authoremail
    ssh-add ~/.ssh/id_rsa
    pbcopy < ~/.ssh/id_rsa.pub

    info 'public key is in clipboard, add ssh key to github'
    open https://github.com/settings/ssh
    pause

    # not using much the https
    # info 'generate token if you prefer to use https'
#
    # open https://github.com/settings/tokens
    # info 'please check https://help.github.com/articles/creating-an-access-token-for-command-line-use/'
    # info "and this https://help.github.com/articles/caching-your-github-password-in-git/ if you don't know or remember what to do with the token"
    # pause

    gpg --full-generate-key
    GPG_KEY=$(gpg --list-secret-keys --keyid-format LONG | grep sec | grep -o "/\([0-9A-Z]\+\)" | grep -o "[0-9A-Z]\+")
    gpg --armor --export $GPG_KEY > pbcopy

    open https://github.com/settings/ssh
    info 'gpg key is in the clipboard add it to github'
    info 'please check https://help.github.com/articles/generating-a-new-gpg-key/'
    pause

    sed -e "s/AUTHORNAME/$authorname_work/g" -e "s/AUTHOREMAIL/$authoremail_work/g" -e "s/USE_GPG/$use_gpg_work/g" -e "s/SIGN_KEY/$GPG_KEY/g" git/gitconfig-work.symlink.example > git/gitconfig-work.symlink
    sed -e "s/AUTHORNAME/$authorname_personal/g" -e "s/AUTHOREMAIL/$authoremail_personal/g" -e "s/USE_GPG/$use_gpg_personal/g" -e "s/SIGN_KEY/$GPG_KEY/g" git/gitconfig-personal.symlink.example > git/gitconfig-personal.symlink
    sed -e "s/CREDENTIAL_HELPER/$credential/g" -e "s/EDITOR/$editor/g" git/gitconfig.symlink.example > git/gitconfig.symlink

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
  
  success 'dotfiles'
}

setup_vim () {
  info 'setting up vim...'
  # install spacevim
  curl -sLf https://spacevim.org/install.sh | bash

  VIM_CONFIG_HOME=$HOME/.SpaceVim.d/

  mkdir -p "$VIM_CONFIG_HOME/autoload/"

  link_file ~/init.toml "$VIM_CONFIG_HOME/init.toml"
  link_file ~/myspacevim.vim "$XDG_CONFIG_HOME/autoload/myspacevim.vim"
}

install_brew () {
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
}

install_packages () {
  info 'installing packages...'

  cat brew/brew_list | while read PACKAGE
  do
    # echo "brew install $PACKAGE"
    brew install $PACKAGE
  done

  # install nodejs
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
  export NVM_DIR=~/.nvm
  nvm install node
}

install_apps () {
  info 'installing apps...'

  cat brew/cask_list | while read APP
  do
    # echo "brew install $APP"
    brew install $APP
  done
}

setup_zsh () {
  # install prezto
  info 'setup zsh and zplug'

  echo 'change default shell to zsh'

  # echo '/usr/local/bin/zsh' >> /etc/shells

  chsh -s /usr/local/bin/zsh

  curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
}

install_brew
install_packages
install_apps
setup_gitconfig
install_dotfiles
setup_vim
setup_zsh
