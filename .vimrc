 " #############################################################################
 " 基本設定
 " #############################################################################
 " ######################################
 " インデント関連
 " ######################################
 "set expandtab      " tab 入力を複数の空白入力に置き換える
 set autoindent     " 改行時に前の行の indent を継続する
  set smartindent    " 改行時の入力行の末尾によって次の行の indent を増減する
 set tabstop=2      " 画面上で tab 文字が占める幅 
 set softtabstop=2  " 連続空白上で tab や BS で cursor が動く幅
 set shiftwidth=2   " 自動 indent でずれる幅
 
 " ######################################
 " キーバインディング関係
 " ######################################
 " #################
 " BS で指定文字を削除可能に設定
 "  start  - 既存の文字を削除できるように設定
 "  eol    - 行頭で BS を使用した場合，上の行と連結
 "  indent - auto indent mode で indent を削除可能に設定
 set backspace=start,eol,indent
 "switching tab
 nnoremap <silent> [b :bprevious<CR>
 nnoremap <silent> ]b :bnext<CR>
 nnoremap <silent> [B :bfirst<CR>
 nnoremap <silent> [B :blast<CR>
 " to switch relative row number and absolute row number
 nnoremap  <silent> ;h :<C-u>relativenumber!<CR>
 " #################
 
 " ######################################
 " 自動入力 補完 機能
 " ######################################
 " 自動的に閉じ括弧を入力
 " pluginのvim-autocloseを利用する
 set wildmenu wildmode=list:full " 補完時の一覧表示機能有効化
 
 " ######################################
 " マウス関連
 " ######################################
 set mouse=a " マウス機能有効化
 
 
 " ######################################
 " 検索関連
 " ######################################
 set incsearch  " incremental 検索を有効化
 set nohlsearch " 検索 keyword をhighlight しないように設定
 
 " ######################################
 " 編集関係
 " ######################################
 " #################
 " Swap / Backup file を全て無効化する
 set nobackup
 set noswapfile
 set nowritebackup
 " #################
 
 " ######################################
 " 表示関連
 " ######################################
 " #################
 " 背景
 " #################
 syntax on
 set background=dark
 
 " #################
 " editor 補助文字表示
 " #################
 set nu
 set wrap             " 長い text の折り返し
 "set list             " 不可視文字の可視化
 "set relativenumber   " 行番号の表示
 "set cursorline       " 編集行を目立たせる
 set textwidth=0      " 自動的に改行が入るのを無効化
 " set colorcolumn=80   " 80文字目に line を入れる
 " #################
 " statusline の表示
 " #################
 set laststatus=2 " statusline を常に表示
 "set statusline=%F%r%h%= " statusline の内容
 
 
 " ######################################
 " 音関連
 " ######################################
 " 前時代的スクリーンベルを無効化
 set t_vb=
 set novisualbell
 
" #############################################################################
" Plugin
" #############################################################################

" ######################################
" Plugin 導入のための設定
" ######################################
filetype plugin indent off
if has('vim_starting')
  set runtimepath+=~/.vim/bundle/neobundle.vim
  call neobundle#begin(expand('~/.vim/bundle/'))
    NeoBundleFetch 'Shougo/neobundle.vim'
  call neobundle#end()
endif
filetype plugin indent on

" ######################################
" 統合 UI
" ######################################
" #################
" Unite.vim
" #################
NeoBundle "Shougo/unite.vim"

let g:unite_enable_start_insert = 1       " input mode で開始

" #################
" Vimfiler.vim
" file viewer
" #################
NeoBundle "Shougo/vimfiler"
let g:vimfiler_as_default_explorer=1 " default file explorer に設定
let g:vimfiler_ignore_pattern='\(\~$\|\.pyc$\|\.[oad]$\)' " 無視する file

let g:vimfiler_safe_mode_by_default = 0 " file 移動や削除などの権限 0:許可
" Edit file by tabedit.
let g:vimfiler_edit_action = 'tabopen'
" Ctrl + f
nnoremap <C-f> :VimFilerExplorer -split -no-quit -auto-cd -winwidth=30<CR>
inoremap <C-f> <ESC>:VimFilerExplorer -split -no-quit -auto-cd -winwidth=30<CR>
nnoremap <C-x><C-f> :VimFiler -project<CR>
inoremap <C-x><C-f> :VimFiler -project<CR>

" #################
" Gundo.vim 
" 編集履歴 list を表示
" #################
NeoBundleLazy "sjl/gundo.vim", {
      \ "autoload": {
      \   "commands": ['GundoToggle'],
      \}}
nnoremap <C-G> :GundoToggle<CR>

" ######################################
" 開発補助関連
" ######################################
" #################
" Shougo/neocomplcache.vim
" #################
NeoBundle "Shougo/neocomplcache.vim"
let g:acp_enableAtStartup                    = 0 " Disable AutoComplPop.
let g:neocomplcache_enable_at_startup        = 1 " Use neocomplcache.
let g:neocomplcache_enable_smart_case        = 1 " Use smartcase.
let g:neocomplcache_min_syntax_length        = 2 " Set minimum syntax keyword length.
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
let g:neocomplcache_temporary_dir            = "~/.vim/tmp/neocomplcache"
" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
         \ 'default' : ''
         \ }
" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()
" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
   return neocomplcache#smart_close_popup() . "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS>  neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y> neocomplcache#close_popup()
inoremap <expr><C-e> neocomplcache#cancel_popup()

"  " #################
"  " vim-addon-manager
"  " #################
"  NeoBundle 'MarcWeber/vim-addon-manager'
"  call vam#ActivateAddons(['neosnippet', 'neosnippet-snippets'])

" #################
" vim-template
" #################
NeoBundle 'thinca/vim-template'  " テンプレ
autocmd User plugin-template-loaded call s:template_keywords()
function! s:template_keywords()
   %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
   %s/<+ClassName+>/\=expand('%:r')/g
endfunction
autocmd User plugin-template-loaded
         \    if search('<+CURSOR+>')
         \  |   execute 'normal! "_da>'
         \  | endif

" #################
" vimproc
"  シンタックスチェック
" #################
NeoBundle 'scrooloose/syntastic'
if ! empty(neobundle#get("syntastic"))
  " Disable automatic check at file open/close
  let g:syntastic_check_on_open=0
  let g:syntastic_check_on_wq=0
  " C
  let g:syntastic_c_check_header = 1
  " C++
  let g:syntastic_cpp_check_header = 1
  " Java
  let g:syntastic_java_javac_config_file_enabled = 1
  let g:syntastic_java_javac_config_file = "$HOME/.syntastic_javac_config"
endif

" #################
" jedi
" python用自動補完プラグイン
" #################
NeoBundle 'davidhalter/jedi-vim'

" #################
" slimv
" sbcl(CLISP)用プラグイン
" #################
NeoBundle 'kovisoft/slimv'

" #################
" vimproc
" 自動でカッコを閉じる
" #################
NeoBundle 'Townk/vim-autoclose'

" #################
" surround.vim 
" 指定文字で囲む
" #################
NeoBundle 'surround.vim'

"" How to surround
" 1. select characters
" 2. Shift + s + ( surround character )
"" How to delete surround
" 1. move a cursor to surrounded character
" 2. d + s + ( surround character )

" #################
" Neosnippet-snippets
" #################
NeoBundle 'Shougo/neosnippet'
NeoBundle 'Shougo/neosnippet-snippets'
" <TAB>: completion.
inoremap <expr><TAB>    pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"

" Plugin key-mappings.
imap <C-k> <Plug>(neosnippet_expand_or_jump)
smap <C-k> <Plug>(neosnippet_expand_or_jump)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
imap <expr><TAB> pumvisible() ? "\<C-n>" : neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" ######################################
" 作業関連
" ######################################
" #################
" vim-quickrun
" #################
NeoBundle 'thinca/vim-quickrun'  " 関数テスター
" コマンドラインオプションを追加する
let g:quickrun_config = {}
" All
let g:quickrun_config = {
      \ '_' : {   
      \ 'runner' : 'vimproc',
      \ 'runner/vimproc/updatetime' : 60,
      \ 'outputter/buffer/split' : ':botright 8sp',
      \ 'outputter' : 'buffer',
      \ 'outputter/buffer/close_on_empty' : 1,
      \ 'hook/time/enable' : 1
      \ },
      \ }
" tex
let g:quickrun_config['tex'] = {
                  \ 'command' : 'bluetex2pdf',
                  \}
nnoremap <C-r> :QuickRun<CR>

" #################
" vimproc
" 非同期実行のため
" #################
NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
    \     'windows' : 'make -f make_mingw32.mak',
    \     'cygwin' : 'make -f make_cygwin.mak', 
    \     'mac' : 'make -f make_mac.mak',
    \     'unix' : 'make -f make_unix.mak',
    \    },
    \ }

" #################
" Vim-latex
" vim 上に latex 環境を整える
" #################
NeoBundle 'lervag/vim-latex'

" ######################################
" 表示関連
" ######################################
" #################
" Lightline.vim 
" ステータスバー 
" #################
NeoBundle 'itchyny/lightline.vim'
let g:lightline = {
         \ 'colorscheme': 'landscape',
         \ 'active' : {
         \   'left' : [ [ 'mode', 'paste' ],
         \              [ 'readonly', 'fugitive', 'filename', 'modified' ] ]
         \ },
         \ 'component': {
         \                'readonly': '%{&readonly?"ReadOnly":""}',
         \                'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
         \                'fugitive': '%{exists("*fugitive#head")?"Branch->(".fugitive#head().")":""}'
         \ },
         \ 'component_visible_condition': {
         \                'readonly': '(&filetype!="help"&& &readonly)',
         \                'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
         \                'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
         \ }             
         \ }

" #################
" Vim-indent-guides
" indent を強調する
" #################
NeoBundle "nathanaelkane/vim-indent-guides"
autocmd VimEnter * IndentGuidesEnable
set ts=2 sw=2 et
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd guibg=green ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=red ctermbg=8

" #################
" Vim-flake8
" python の構文 check 
" #################
NeoBundle 'nvie/vim-flake8'

" ######################################
" colorscheme
" ######################################
"colorscheme jellybeans
"let g:jellybeans_overrides = {
"\    'Todo': { 'guifg': '303030', 'guibg': 'f0f000',
"\              'ctermfg': 'Black', 'ctermbg': 'Yellow',
"\              'attr': 'bold' },
"\}

NeoBundle 'tomasr/molokai'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundle 'altercation/vim-colors-solarized'


" ######################################
" Plugin の設定終了
" ######################################
call neobundle#end()

NeoBundleCheck

filetype plugin indent on 

colorscheme molokai
