"leaderキー設定
let mapleader="\<Space>"

"##################################################
"#
"# dein
"#
"##################################################

if &compatible
  set nocompatible
endif

let s:dein_dir='~/.cache/dein'
let s:dein_dir_repo_dir=expand(s:dein_dir).'/repos/github.com/Shougo/dein.vim'
let s:toml_dir=$XDG_CONFIG_HOME.'/nvim/dein_toml'

if !isdirectory(s:dein_dir_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim.git '.shellescape(s:dein_dir_repo_dir))
endif

execute 'set runtimepath+='.s:dein_dir_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " toml読み込み
  call dein#load_toml(s:toml_dir.'/dein.toml')
  call dein#load_toml(s:toml_dir.'/filer.toml')
  call dein#load_toml(s:toml_dir.'/coc.toml')
  call dein#load_toml(s:toml_dir.'/coding.toml')

  call dein#end()
  call dein#save_state()
endif

filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif

"########################################
"#
"# vim設定
"#
"########################################

"24bit colorを有効化
set termguicolors

"インデント設定
set cindent
set autoindent

"表示設定
syntax on
set list
set number
set cursorline
set laststatus=2

"タブ設定
set ts=4 sts=4 sw=4 et

"改行コード、文字コード設定
set encoding=utf-8
set fileformat=unix

"不要なファイルの生成抑止
set noundofile
set nobackup

"自動折り返し無効化
set textwidth=0

"<C-@>誤爆防止
inoremap <C-@> <Esc>

"<C-j>で挿入モードから抜ける
inoremap <C-j> <Esc>

"<C-j>でビジュアルモードから抜ける
vnoremap <C-j> <Esc>

"<C-j>でTerminal-Jobモードから抜ける
tnoremap <C-j> <C-\><C-n>

"タブ切り替え
noremap <C-n> gt
noremap <C-p> gT

"ウィンドウ移動
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader><C-h> <C-w>H
nnoremap <leader><C-j> <C-w>J
nnoremap <leader><C-k> <C-w>K
nnoremap <leader><C-l> <C-w>L

"split時の挙動設定
set splitright
set splitbelow

"全角記号表示のための設定
set ambiwidth=double

"クリップボード操作
if has('unix')
  vnoremap <leader>y "+y
  vnoremap <leader>d "+d
  vnoremap <leader>D "+D
  nnoremap <leader>y "+y
  nnoremap <leader>d "+d
  nnoremap <leader>D "+D
else
  vnoremap <leader>y "*y
  vnoremap <leader>d "*d
  vnoremap <leader>D "*D
  nnoremap <leader>y "*y
  nnoremap <leader>d "*d
  nnoremap <leader>D "*D
endif
vnoremap <leader>p "*p
vnoremap <leader>P "*P
nnoremap <leader>p "*p
nnoremap <leader>P "*P

" Perl providerを使用しないので無効化
let g:loaded_perl_provider = 0

" カレントウィンドウの行数の1/4のサイズでsplitしてターミナル表示
command! Sterminal call SplitTerminal()
nnoremap <leader>tt :Sterminal<CR>i
function! SplitTerminal()
    let l:win_height = &lines / 4
    execute 'botright '.l:win_height.'split'
    execute 'terminal'
    execute 'set nonumber'
endfunction

" vsplitしてターミナル表示
command! Vterminal call VerticalSplitTerminal()
nnoremap <leader>tv :Vterminal<CR>i
function! VerticalSplitTerminal()
    execute 'rightbelow vertical split'
    execute 'terminal'
    execute 'set nonumber'
endfunction
