" 语法高亮
syntax on
" 修改tab键为4个空格
set ts=4
set sw=4
" 光标匹配
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 搜索结果高亮
set hlsearch
" 用浅色高亮当前行 
autocmd InsertEnter * se cul      
" 开启实时搜索，搜索时，每输入一个字符，就自动跳到第一个匹配的结果
set incsearch
" 搜索忽略大小写
set ignorecase
" vim 自身命令行模式智能补全
set wildmenu
" 不创建备份文件
set nobackup
" 不创建交换文件
set noswapfile
" 保留撤销历史
set undofile
set undodir=~/.vim/.undo//
" 出错时不发出响声
set noerrorbells
" 命令模式 tab 键补全
set wildmenu
set wildmode=longest:list,full
" 不与 Vi 兼容
set nocompatible
" 显示模式
set showmode
" 支持鼠标
set mouse=a
" utf-8 编码
set encoding=utf-8
" 启动 pathogen 插件管理器
" execute pathogen#infect()
" 开启文件类型侦查
""filetype on
" 根据侦查到的不同类型加载对应的插件，比如C++文件加载C++对应的插件
filetype plugin on
" 为特定文件类型载入相关缩进文件
filetype indent on
" 显示当前行号列号
"set ruler
" 显示行号
set number
" 显示中文帮助
set helplang=cn
" 历史记录数
set history=1000
" 让配置变更成保存时自动重启加载生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC
" 设置默认模板文件
autocmd BufNewFile *.html 0r /home/xcq/.vim/vimfiles/template.html
autocmd BufNewFile *.py 0r /home/xcq/.vim/vimfiles/template.py
autocmd BufNewFile *.c 0r /home/xcq/.vim/vimfiles/template.c
" autocmd BufNewFile *.html 0r /home/xcq/.vim/vimfiles/template.py

" 映射快捷键
" 读写模式
" 括号自动补全
""inoremap ( ()<ESC>i
""inoremap { {}<ESC>i
""inoremap [ []<ESC>i
""inoremap " ""<ESC>i
" Ctrl+i---->ESC键
imap <C-I> <ESC> 
" 配置 Plugin NERDTree
"" 将F2设置为开关:NERDTree的快捷键   
map <F2> :NERDTree<CR>
"map :silent! NERDTreeToggle
"" 窗口尺寸
let g:NERDTreeSize=30
"" 窗口位置
let g:NERDTreeWinPos='right'
"" 修改树的显示图标
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
"" 当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"" 打开vim时自动打开NERDTree
"autocmd vimenter * NERDTree
"" 打开NERDTree窗口时,自动显示Bookmarks
"let NERDTreeShowBookmarks=1

" Vundle 环境设置
filetype off
set rtp+=~/.vim/bundle/Vundle.vim

" Vundle 管理的插件列表必须位于 vundle#begin() 和 vundle#end() 之间
" 删除插件方法：先在下面删除对应行，在 :BundleClean
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'chemzqm/wxapp.vim'
" 插件列表结束
call vundle#end()
