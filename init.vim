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
let s:toml_file=$XDG_CONFIG_HOME.'/nvim/dein.toml'

if !isdirectory(s:dein_dir_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim.git '.shellescape(s:dein_dir_repo_dir))
endif

execute 'set runtimepath+='.s:dein_dir_repo_dir

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  if filereadable(s:toml_file)
    call dein#load_toml(s:toml_file)
  endif
  call dein#load_toml(s:toml_file)
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

"leaderキー設定
let mapleader=","

"<C-@>誤爆防止
inoremap <C-@> <Esc>

"<C-j>で挿入モードから抜ける
inoremap <C-j> <Esc>

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

nnoremap <Space><C-h> <C-w>H
nnoremap <Space><C-j> <C-w>J
nnoremap <Space><C-k> <C-w>K
nnoremap <Space><C-l> <C-w>L

"split時の挙動設定
set splitright
set splitbelow

"全角記号表示のための設定
set ambiwidth=double

"クリップボード操作
if has('unix')
  vnoremap <Space>y "+y
  nnoremap <Space>y "+y
else
  vnoremap <Space>y "*y
  nnoremap <Space>y "*y
endif
vnoremap <Space>p "*p
nnoremap <Space>p "*p
nnoremap <Space>P "*P
