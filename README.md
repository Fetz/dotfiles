# FETZ's dotfiles
[About](#about) &nbsp;|&nbsp; [What's inside](#whats-inside) &nbsp;|&nbsp; [Docs](#docs) &nbsp;|&nbsp; [Installation](#installation) &nbsp;|&nbsp;  [TODO](#TODO)|&nbsp;  [License](#license)
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

## Docs
- keyboard:
  - [internal keyboard config](docs/karabiner.md)
  - [infinity ergodox](docs/infinity.md)
- [vim](docs/vim.md)
- [tmux](docs/tmux.md)

## Installation

```shell
$ cd ~
$ git clone git@github.com:Fetz/dotfiles.git dotfiles/fetz
$ sh dotfiles/fetz/bootstrap.sh
```

Use at your own risk!

## TODO
- [ ] zsh
  - [ ] find a better way to visualize normal/insert mode swap, that doesn't cause char issues in tmux and vim/emacs
  - [ ] set slc registry with a public/private npm swap
  - [ ] improve how docker is handled, check docker mac osx native app
- [ ] vim/neovim
  -  [ ] improve guide key like file search and such
  -  [ ] editor lint is not yet working
  -  [ ] improve ternjs with react (jsx) and babel
  -  [ ] add a way to swap or open test next to the main file
- [ ] spacemacs
  - [ ] improve js/react highlight
  - [ ] find a way to force jsx in some js files

## License

FETZ's dotfiles is licensed under the [MIT License](LICENSE).
