# FETZ's dotfiles
[About](#about) &nbsp;|&nbsp; [What's inside](#whats-inside) &nbsp;|&nbsp; [Docs](#docs) &nbsp;|&nbsp; [Installation](#installation) &nbsp;|&nbsp; [TODO](#TODO)&nbsp;|&nbsp; [License](#license)
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

<img width="1436" alt="screen shot 2016-05-12 at 02 16 21" src="https://user-images.githubusercontent.com/1071113/44960592-49527d80-aefa-11e8-9516-cf20282c8d85.png">

## About
inspired by dotfiles from:
- [mathiasbynens](https://github.com/mathiasbynens/dotfiles)
- [holman](https://github.com/holman/dotfiles)
- and probably others

## What's inside
- tmux, nvim, vim with spacevim
- setup git to use ssh and add 2 different configs, one for work and another personal
- brew/cask to install some apps and libs needed
- tmux with plugins
- zsh with zplug plugins

## Docs
- [apps](docs/apps.md)
- [cli](docs/cli.md)
- [git](docs/git.md)
- [infinity ergodox](docs/infinity.md) keyboard config
- [iterm2](docs/iterm.md)
- [tmux](docs/tmux.md)
- [vim](docs/vim.md)
- [zsh](docs/zsh.md)


## Installation

```shell
$ cd ~
$ git clone git@github.com:Fetz/dotfiles.git dotfiles/fetz
$ sh dotfiles/fetz/bootstrap.sh
```

Use at your own risk!

## TODO
- [ ] Improve readme with shortcuts and explanations of plugins and tools used

## License

FETZ's dotfiles is licensed under the [MIT License](LICENSE).
