# FETZ's dotfiles
[About](#about) &nbsp;|&nbsp; [What's inside](#whats-inside) &nbsp;|&nbsp; [Installation](#installation) &nbsp;|&nbsp;  [License](#license)
```
  █████▒▓█████▄▄▄█████▓▒███████▒   ▓█████▄  ▒█████  ▄▄▄█████▓  █████▒██▓ ██▓    ▓█████   ██████ 
▓██   ▒ ▓█   ▀▓  ██▒ ▓▒▒ ▒ ▒ ▄▀░   ▒██▀ ██▌▒██▒  ██▒▓  ██▒ ▓▒▓██   ▒▓██▒▓██▒    ▓█   ▀ ▒██    ▒ 
▒████ ░ ▒███  ▒ ▓██░ ▒░░ ▒ ▄▀▒░    ░██   █▌▒██░  ██▒▒ ▓██░ ▒░▒████ ░▒██▒▒██░    ▒███   ░ ▓██▄   
░▓█▒  ░ ▒▓█  ▄░ ▓██▓ ░   ▄▀▒   ░   ░▓█▄   ▌▒██   ██░░ ▓██▓ ░ ░▓█▒  ░░██░▒██░    ▒▓█  ▄   ▒   ██▒
░▒█░    ░▒████▒ ▒██▒ ░ ▒███████▒   ░▒████▓ ░ ████▓▒░  ▒██▒ ░ ░▒█░   ░██░░██████▒░▒████▒▒██████▒▒
 ▒ ░    ░░ ▒░ ░ ▒ ░░   ░▒▒ ▓░▒░▒    ▒▒▓  ▒ ░ ▒░▒░▒░   ▒ ░░    ▒ ░   ░▓  ░ ▒░▓  ░░░ ▒░ ░▒ ▒▓▒ ▒ ░
 ░       ░ ░  ░   ░    ░░▒ ▒ ░ ▒    ░ ▒  ▒   ░ ▒ ▒░     ░     ░      ▒ ░░ ░ ▒  ░ ░ ░  ░░ ░▒  ░ ░
 ░ ░       ░    ░      ░ ░ ░ ░ ░    ░ ░  ░ ░ ░ ░ ▒    ░       ░ ░    ▒ ░  ░ ░      ░   ░  ░  ░  
           ░  ░          ░ ░          ░        ░ ░                   ░      ░  ░   ░  ░      ░  
                       ░            ░                                                           
```

<img width="1436" alt="screen shot 2016-05-12 at 02 16 21" src="https://cloud.githubusercontent.com/assets/1071113/15201365/3099f0da-17e8-11e6-9fda-e43010fe6705.png">

## About
inspired by dotfiles from:
- [mathiasbynens](https://github.com/mathiasbynens/dotfiles)
- [holman](https://github.com/holman/dotfiles)
- and probably others

## What's inside
- true color terminal (nvim/tmux/iterm)
- setup git to use both ssh and https github token
- brew/cask to install some apps and libs needed
- vim/neovim dotfile
  - plug - plugin manager
  - gruvbox - theme
  - vim leader guide - similar to whick key / guide key
- tmux
  - theme_airline
  - tmux plugin
    - fpp
    - yank
    - copycat
    - sensible
- spacemacs dotfile
- zsh (pretzo)
- Amethyst tiling window manager ala xmonad and i3

## Installation

```shell
$ cd ~
$ git clone git@github.com:Fetz/dotfiles.git dotfiles/fetz
$ sh dotfiles/fetz/bootstrap.sh
```

Use at your own risk!

## License

FETZ's dotfiles is licensed under the [MIT License](LICENSE).
