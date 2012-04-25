call pathogen#infect()
syntax on
filetype plugin indent on

set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

" 关闭备份
set nobackup

"encoding
set fileencodings=utf-8,gb2312,gbk,gb18030
set termencoding=utf-8
set encoding=prc

" 隐藏窗口
set guioptions-=T
" 窗口打开时最大化
au GUIENTER * simalt ~x

" 在处理未保存或只读文件的时候，弹出确认
set confirm

" 当文件在外部有改动时，自动加载
set autoread

" 设置匹配模式，类似当输入一个左括号时会匹配相应的那个右括号
set showmatch

" 高亮显示查找结果
set hlsearch
" 增量查找
set incsearch
" 替换时,使用g标签成为默认设置. 在替换时,替换本行所有符合的匹配
set gdefault

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Tab键的宽度
set expandtab
set smarttab
" 不要用空格代替制表符
set noexpandtab


" 缩进
set tabstop=4
set softtabstop=4
set shiftwidth=4
set autochdir

set ai "Auto indent
set si "Smart indet
set wrap "Wrap lines

" 显示行号
set number
set lbr
set tw=80

""""""""""""""""""""""""""""""
" => Visual mode related
""""""""""""""""""""""""""""""
" Really useful!
"  In visual mode when you press * or # to search for the current selection
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :call VisualSearch('gv')<CR>
map <leader>g :vimgrep // **/*.<left><left><left><left><left><left><left>


function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

" From an idea by Michael Naumann
function! VisualSearch(direction) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("vimgrep " . '/'. l:pattern . '/' . ' **/*.')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction

" 历史记录数
set history=1000

"语言设置
set langmenu=zh_CN.UTF-8
set helplang=cn

let mapleader = ","
let g:mapleader = ","

" 我的状态行显示的内容（包括文件类型和解码）
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
"set statusline=[%F]%y%r%m%*%=[Line:%l/%L,Column:%c][%p%%]

" 总是显示状态行
"set laststatus=2

" 设置背景色
set background=dark
colo darkblue

" set position and size
set lines=45 columns=158

"show cmd
set showcmd

"打开当前目录文件列表
:map <F3>:e .<CR>
"按F8智能补全
:inoremap <F8> <C-x><C-o>

"vim inoremap python code
" filetype on
" filetype plugin on
" filetype plugin indent on
" :let g:pydiction_location='C:/Program Files (x86)/Vim/vimfiles/ftplugin/pydiction/complete-dict'
" :let g:pydiction_menu_height=20

" TlistToggle plugin
let g:tagbar_ctags_bin='C:\Program Files (x86)\Vim\vimfiles\bundle\ctags58\ctags.exe'
:nmap <F9> :TagbarToggle<CR>

let g:pydoc_cmd = "Python c:/Python27/Lib/pydoc.py"
if has("autocmd")
	" 设置输入点(.)时,自动弹出函数菜单
    autocmd FileType python imap <buffer> . .<C-X><C-O><C-P>
endif

" 运行Python脚本的键盘映射
map <F5> :!python.exe %

"Grep
nnoremap <silent> <F3> :Grep<CR>

" remove space end line
autocmd BufWritePre * :%s/\s\+$//e

" Highlight end of line whitespace.
highlight WhitespaceEOL ctermbg=red guibg=red
match WhitespaceEOL /\s\+$/

" 语法高亮
" set font
set guifont=Courier\ New:h12:cANSI
colorscheme jellybeans

let g:SuperTabDefaultCompletionType = "context"
