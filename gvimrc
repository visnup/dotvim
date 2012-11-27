if has("gui_macvim")
  set fuoptions=maxhorz,maxvert

  " cmd-t is open a new tab and start command-t
  macmenu &File.New\ Tab key=<D-T>
  map <D-t> :tab new<CR>:CtrlP<CR>
  imap <D-t> <Esc>:tab new<CR>:CtrlP<CR>

  " cmd-return for full screen
  macmenu Window.Toggle\ Full\ Screen\ Mode key=<D-CR>

  " Command-Shift-F for Ack
  map <D-F> :Ack<space>
endif
