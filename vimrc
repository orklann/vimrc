set nonu

cabbrev t tabnew
cabbrev tn tabnext
cabbrev tp tabprevious

map <c-u> :tabprevious<CR>
imap <c-u> <ESC>:tabprevious<CR>
map <c-i> :tabnext<CR>
imap <c-i> <ESC>:tabnext<CR>
map <c-j> <c-f>
map <c-k> <c-b>

" In visual mode, use Y to copy to system clipboard
vnoremap Y "*y

" In normal mode, do the same with the current line
nnoremap Y "*yy

" vv = V
nnoremap vv V

" yank also copy to system  pasteboad
set clipboard=unnamed

" yank also copy to system clipboard for Ubuntu
set clipboard=unnamedplus

" Easy way for ^, $
nnoremap <silent> e ^
vnoremap <silent> e ^
nnoremap <silent> r $
vnoremap <silent> r $
nnoremap <silent> t 0
vnoremap <silent> t 0
nnoremap <silent> s e

" gg, GG shortcuts
noremap <silent> <nowait> G GG

" New line
nmap <CR> o<Esc>i

" Hide coloration of found words
map <C-C> :nohlsearch<CR>

" Tab to switch tabline
noremap <Tab> :tabnext<CR>

" Disable mouse
set mouse=

" Set colors for the active tab line
hi TabLineSel ctermfg=white ctermbg=black guifg=white guibg=black

" Set colors for other tab lines
hi TabLine ctermfg=blue ctermbg=NONE guifg=blue guibg=NONE

" Remove background color from non-tab areas of the tab line
hi TabLineFill cterm=NONE ctermbg=NONE gui=NONE guibg=NONE

hi User1 ctermfg=81

" Status text
fun! GetPaddingSpaces(s)
  let w = winwidth('%')
  let width = &modified ? w - 1: w
  let padding = (width - len(a:s)) / 2
  return repeat('\ ', padding)
endfun

fun! GetStatus()
  let sign = &modified ? '*' : ''
  let lineNumber= repeat('1', len(printf('%i', getline('.'))))
  let columnNumber = repeat('1', len(printf('%i', virtcol('.'))))
  "let fullPath = fnameescape(pathshorten(expand('%:p:h')))
  let filename = fnameescape(expand('%:t'))
  "let path = fullPath.'/'.filename.':'.lineNumber.':'.columnNumber
  "
  let fullPath = ""
  let path="[•Tommy•]".filename.":%1:%c"
  let spaces = GetPaddingSpaces(path)

  let s = 'set statusline=%2*'.sign.spaces.'%1*'."[•Tommy•]".'%1*'.filename.'%1*:%l:%1*%c'
  exec s
endfun

"This make custom status line work
set laststatus=2

autocmd CursorMoved * call GetStatus()
autocmd BufWritePost * call GetStatus()
autocmd BufRead,BufNewFile * call GetStatus()
autocmd! BufRead,BufNewFile * call GetStatus()
autocmd! BufEnter * call GetStatus()
autocmd VimEnter * call GetStatus()

" Set tab line
set tabline=%!GetTabLine()

function! GetTabLine()
  let line = ''
  let s:current_tab = tabpagenr()
  for i in range(tabpagenr('$'))
    let bufnr = tabpagebuflist(i+1)[0]
    let bufname = bufname(bufnr)
    let tab_label = fnamemodify(bufname, ':t')
    if i+1 == s:current_tab
      let line .= '%' . (i+1) . 'T%#TabLineSel#' . tab_label . ' %#TabLine#'
    else
      let line .= '%' . (i+1) . 'T%#TabLine#' . tab_label . ' '
    endif
  endfor
  return line
endfunction
