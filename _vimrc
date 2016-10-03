source ~/dotfiles/_vimrc.bundle

"-------------------------------------------------------------------------------
" カラー設定:
:colorscheme evening              " (GUI使用時)

"-------------------------------------------------------------------------------
" 基本設定 Basics
"-------------------------------------------------------------------------------
set nocompatible                                  " vi互換なし
set textwidth=0                                   " 一行に長い文章を書いていても自動折り返しをしない
set tabstop=4                                     " タブストップ
set shiftwidth=4                                  " シフト量
set nobackup                                      " バックアップ取らない
set noswapfile                                    " スワップファイル作らない
set noundofile                                    " undoファイル作成を無効にする
set autoread                                      " 他で書き換えられたら自動で読み直す
set hidden                                        " 編集中でも他のファイルを開けるようにする
set backspace=indent,eol,start                    " バックスペースでなんでも消せるように
set formatoptions=lmoq                            " テキスト整形オプション，マルチバイト系を追加
set vb t_vb=                                      " ビープを鳴らさない
set browsedir=buffer                              " Exploreの初期ディレクトリ
set whichwrap=b,s,h,l,<,>,[,]                     " カーソルを行頭、行末で止まらないようにする
set showcmd                                       " コマンドをステータス行に表示
set showmode                                      " 現在のモードを表示
set viminfo='50,<1000,s100,\"50                   " viminfoファイルの設定
set modelines=0                                   " モードラインは無効
set incsearch                                     " インクリメンタル検索
if has("migemo")
  set migemo
endif
set hlsearch                                      " 検索ハイライト
set virtualedit=block                             " 行末以降の同じ列にテキストを入力できるようにする

set clipboard+=unnamed                            " ヤンクした文字は 、システムのクリップボードに入れる

" ターミナルでマウスを使用できるようにする
set mouse=a
set guioptions+=a
set ttymouse=xterm2

"-------------------------------------------------------------------------------
" ステータスライン StatusLine
"-------------------------------------------------------------------------------
set laststatus=2                                  " 常にステータスラインを表示
set ruler                                         "カーソルが何行目の何列目に置かれているかを表示する

"ステータスラインに文字コードと改行文字を表示する
set statusline=%<%f\ %m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}%=%l,%c%V%8P

"-------------------------------------------------------------------------------
" 表示 Apperance
"-------------------------------------------------------------------------------
set showmatch                                     " 括弧の対応をハイライト
set number                                        " 行番号表示
set list                                          " 不可視文字表示
set listchars=tab:>.,trail:_,extends:>,precedes:< " 不可視文字の表示形式
set display=uhex                                  " 印字不可能文字を16進数で表示
set wildmenu                                      " 補完候補をコマンドラインのすぐ上の行に表示する

" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

" カーソル行をハイライト
set cursorline
" カレントウィンドウにのみ罫線を引く
augroup cch
  autocmd! cch
  autocmd WinLeave * set nocursorline
  autocmd WinEnter,BufRead * set cursorline
augroup END

:hi clear CursorLine
:hi CursorLine gui=underline
highlight CursorLine ctermbg=black guibg=black

if has('multi_byte_ime') || has('xim')
    " 日本語入力ON時のカーソルの色を設定
    highlight CursorIM guibg=Purple guifg=NONE
endif

" ファイルオープン時にカーソル位置を最後にカーソルがあった位置まで移動
:au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" ファイルオープン時にカレントディレクトリを変更
augroup grlcd
  autocmd!
  autocmd BufEnter * lcd %:p:h
augroup END

" vimgrepでの検索後，QuickFixウィンドウを開く
augroup grepopen
  autocmd!
  autocmd QuickfixCmdPost vimgrep cw
augroup END

" PHPファイル保存時にプログラムの構文チェックを実行する
"augroup phpsyntaxcheck
"  autocmd!
"  autocmd BufEnter *.php w !php -l
"augroup END

" 保存時に行末の空白を除去する
autocmd BufWritePre * :%s/\s\+$//ge
" 保存時にtabをスペースに変換する
"autocmd BufWritePre * :%s/\t/  /ge

"-------------------------------------------------------------------------------
" ファイルごとの設定
"-------------------------------------------------------------------------------
filetype plugin indent on       " ファイルタイプ判定をon

" タブ・空白の設定
autocmd FileType html setlocal noexpandtab
autocmd FileType php  setlocal expandtab
autocmd FileType diag setlocal noexpandtab
autocmd FileType js   setlocal expandtab

"-------------------------------------------------------------------------------
" キーマップ Keymap
"-------------------------------------------------------------------------------
"Escの2回押しでハイライト消去
nmap <Esc><Esc> :nohlsearch<CR><Esc>

"次のタブに移動
nmap <C-Tab>    gt
"前のタブに移動
nmap <C-S-Tab>  gT
