# Tmux

I'm using Tmux with [Tmux plugins](https://github.com/tmux-plugins/tpm) + a simplified airline tmux theme.

<img width="1440" alt="screen shot 2018-09-02 at 21 57 49" src="https://user-images.githubusercontent.com/1071113/44960656-4310d100-aefb-11e8-98af-d2c0895cb7cf.png">

## Tmux plugins used

- [tmux-plugins/tmux-sensible](https://github.com/tmux-plugins/tmux-sensible)
- [tmux-plugins/tmux-yank](https://github.com/tmux-plugins/tmux-yank)
- [tmux-plugins/tmux-copycat](https://github.com/tmux-plugins/tmux-copycat)
- [tmux-plugins/tmux-sessionist](https://github.com/tmux-plugins/tmux-sessionist)
- [jbnicolai/tmux-fpp](https://github.com/tmux-plugins/tmux-fpp)
- [tmux-plugins/tmux-battery](https://github.com/tmux-plugins/tmux-battery)
- [tmux-plugins/tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect)
- [tmux-plugins/tmux-continuum](https://github.com/tmux-plugins/tmux-continuum)

[for updated list](../tmux/tmux.conf.symlink)

## TMUX keyboard config
  
Tmux modifier prefix `CTRL-a`

### Panes

### Panes Navigation
- `CTRL-a h` or `CTRL-a LEFT` move to the left pane
- `CTRL-a l` or `CTRL-a RIGHT` move to the right pane
- `CTRL-a k` or `CTRL-a UP` move to the top pane
- `CTRL-a j` or `CTRL-a DOWN` move to the top pane

### Panes Creation
- `CTRL-a |` create a horizontal split pane
- `CTRL-a -` create a vertical split pane

### Panes Deletion
- `CTRL-a x` delete current pane

### Panes Resize
- `CTRL-a L` resize pane to the right
- `CTRL-a H` resize pane to the left
- `CTRL-a K` resize pane to the top
- `CTRL-a J` resize pane to the bottom

### Panes Move
- `CTRL-a SPACE` toggle between layouts
- `CTRL-a o` swap panes
- `CTRL-a }` move current panes to the right
- `CTRL-a {` move current panes to the left
- `CTRL-a z` toggle zoom of the current pane (distract free mode/focus mode)

### Panes MISC
- `CTRL-a q` show pane numbers

### Windows

#### Windows Navigation
- `CTRL-a [1-9]` move to window

#### Windows Creation
- `CTRL-a c` create a new window

#### Windows Deletion
- `CTRL-a &` delete current window

#### Windows MISC
- `CTRL-a ,` rename a window

### Sessions

#### Sessions Navigation
- `CTRL-a s` move to a session or window
- `CTRL-a g` type and move to that session
- `CTRL-a S` move to the last session

### Sessions creation
- `CTRL-a C` create a new session

### Sessions deletion
- `CTRL-a X` delete a new session

### MISC
- `CTRL-a R` reload tmux.conf

### Plugins
- `CTRL-a I` install tmux plugins

#### Copy-cat + Yank
- `<select-a-text> y` copy the selected text
- `<select-a-text> Y` copy & paste the selected text on the pane
- `CTRL-a /` search for some text/regex

