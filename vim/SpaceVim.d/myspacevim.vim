" Run a given vim command on the results of alt from a given path.
" See usage below.
function! AltCommand(path, vim_command)
  let l:alternate = system("alt " . a:path)
  if empty(l:alternate)
    echo "No alternate file for " . a:path . " exists!"
  else
    exec a:vim_command . " " . l:alternate
  endif
endfunction

func! myspacevim#before() abort
  set timeoutlen=1000 ttimeoutlen=0

  " spacevim autoload functions
  call SpaceVim#custom#SPC('nore', ['f', 'v', 'a'], 'e ~/.SpaceVim.d/autoload/myspacevim.vim', 'autoload', 1)

  " tmux conf
  call SpaceVim#custom#SPC('nore', ['f', 'v', 't'], 'e ~/.tmux.conf', 'tmux', 1)

  " tmux status bar template
  call SpaceVim#custom#SPC('nore', ['f', 'v', 's'], 'e ~/.theme_airline.tmux', 'tmux airline', 1)

  " zsh config
  call SpaceVim#custom#SPC('nore', ['f', 'v', 'z'], 'e ~/.zshrc', 'zsh', 1)

  " Tests
  call SpaceVim#custom#SPCGroupName(['k'], '+Test')
  call SpaceVim#custom#SPC('nore', ['k', 'n'], 'TestNearest', 'nearest', 1)
  call SpaceVim#custom#SPC('nore', ['k', 'f'], 'TestFile', 'file', 1)
  call SpaceVim#custom#SPC('nore', ['k', 's'], 'TestSuite', 'suite', 1)
  call SpaceVim#custom#SPC('nore', ['k', 'l'], 'TestLast', 'last', 1)
  call SpaceVim#custom#SPC('nore', ['k', 'v'], 'TestVisit', 'visit', 1)
  call SpaceVim#custom#SPC('nore', ['k', 't'], 'A', 'alternate source/test', 1)
  call SpaceVim#custom#SPC('nore', ['k', '/'], 'AV', 'alternate vSplit', 1)
  call SpaceVim#custom#SPC('nore', ['k', '-'], 'AV', 'alternate hSplit', 1)
endf

func! myspacevim#after() abort
  nnoremap ∆ :m .+1<CR>==
  nnoremap ˚ :m .-2<CR>==

  inoremap ∆ <Esc>:m .+1<CR>==gi
  inoremap ˚ <Esc>:m .-2<CR>==gi

  vnoremap ∆ :m '>+1<CR>gv=gv
  vnoremap ˚ :m '<-2<CR>gv=gv
endf
