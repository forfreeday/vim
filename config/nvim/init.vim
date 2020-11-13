"--------------------------------------
" VIM 自身配置
"--------------------------------------
set nocompatible              " 去除VI一致性,必须
filetype off                  " 在使用某些插件，需要打开
" 列高亮
set cursorcolumn
set number
syntax on
" 设置 table 宽度
"set tabstop=4
set ts=4
set softtabstop=4
set shiftwidth=4
set expandtab  " noexpandtab 以tab缩进 / expandtab 以空格缩进
%retab

" 设置一个快速退出键
map <F12> :wqa!<CR>

" 设置Startify 快捷键
map <F4> :Startify<cr>
" 搜索单词高亮
set hlsearch
" 忽略大小写
set ignorecase
" 不出现声响
set noerrorbells
" 不要 .swp 文件
set noswapfile
set showcmd
" 继承前一行的缩进方式，适用于多行注释
set autoindent

" 设置空白字符的视觉提示
set list listchars=extends:❯,precedes:❮,tab:▸\ ,trail:˽
"设置样式
colorscheme molokai
" ruby 支持
let g:ruby_host_prog = '/usr/bin/ruby'






"--------------------------------------
" VIM 自带颜色配置
"--------------------------------------
"光标选中部分的底色
hi Visual      guibg=#99cc99  guifg=#334433    gui=none ctermbg=9 ctermfg=15


"--------------------------------------
" 插件管理
"--------------------------------------
call plug#begin()

" 状态栏 和主题
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" 代码注释, 例 \cc \ci
Plug 'scrooloose/nerdcommenter'
"树结构
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" 模糊查询
Plug 'ctrlpvim/ctrlp.vim'

" coc 自动补全插件
Plug 'neoclide/coc.nvim', {'branch': 'release'}




" 缩进线
Plug 'Yggdroot/indentLine'

" 函数导航
Plug 'majutsushi/tagbar'

"启动首页
Plug 'mhinz/vim-startify'

" 与 IDEA 交互，这个确实有用
Plug 'beeender/Comrade'


call plug#end()

"--------------------------------------
" vim-airline 主题配置，更多主题 .config/nvim/plugged/vim-airline-themes/autoload/airline/themes
"--------------------------------------
" 显示顶部状态栏， 打开后，tabline和tmuxline都可以得到增强
set encoding=utf-8
set langmenu=zh_CN.UTF-8

" 显示颜色
set t_Co=256 "终端开启256色支持"
set laststatus=2  "1为关闭底部状态栏 2为开启"
" 自定义主题
let g:airline_theme='molokai'
"安装字体后必须设置
let g:airline_powerline_fonts = 1
" 开启tabline
let g:airline#extensions#tabline#enabled = 1
" tabline中当前buffer两端的分隔字符
"let g:airline#extensions#tabline#left_sep = ' '
" tabline中未激活buffer两端的分隔字符
"let g:airline#extensions#tabline#left_alt_sep = '|'
" tabline中buffer显示编号
let g:airline#extensions#tabline#buffer_nr_show = 1
" 映射切换buffer的键位
let g:airline_detect_modified=1
let g:airline_detect_paste=1

"--------------------------------------
" 切换 Table，这个功能可以方便的切换buffer
"--------------------------------------
map <tab> :bn<cr> "设置tab键映射"
map  <S-tab> :bp<cr> "设置tab键映射"
map  <S-q> :bp\|bd #<cr> "关闭buffer"


"--------------------------------------
"文件树配置
"--------------------------------------
"
"
"使用F2键快速调出和隐藏它
map <F2> :NERDTreeToggle<CR>
"nmap <C-q>
nmap ,d  :b#<bar>bd#<CR>
let NERDTreeChDirMode=1
"显示书签"
let NERDTreeShowBookmarks=1
"设置忽略文件类型"
let NERDTreeIgnore=['\~$', '\.pyc$', '\.swp$']
"窗口大小"
let NERDTreeWinSize=30
" 修改默认箭头
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'


" \ + r 定位当前文件所在目录
map <leader>r :NERDTreeFind<cr> <C-w><C-w>

" 每次进入、退出方法的时候切换目录
map <C-]> <C-]> :NERDTreeFind<cr> <C-w><C-w>
map <C-o> <C-o> :NERDTreeFind<cr> <C-w><C-w>


" 自己写的判断启动路径
function! SomeCheck()
    if filereadable(expand("%"))
    elseif argc() == 1

    else
       autocmd VimEnter * Startify
   endif
endfunction

call SomeCheck()
"当启动Vim时，如果没有指定要打开的文件，就启动NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

"当NERDTree为剩下的唯一窗口时自动关闭
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"启动 VIM 时打开，Startify 一定要放在 NERDTree前执行才有效
autocmd VimEnter * NERDTree
" 文件树设置 {{{
" 关闭NERDTree快捷键
map <leader>t :NERDTreeToggle<CR>
""修改树的显示图标
let g:NERDTreeDirArrowExpandable = '▶'
let g:NERDTreeDirArrowCollapsible = '▽'
let NERDTreeAutoCenter=1
" 显示行号
let NERDTreeShowLineNumbers=0
" 是否显示隐藏文件
let NERDTreeShowHidden=1
" 设置宽度
let NERDTreeWinSize=35
" 在终端启动vim时，共享NERDTree
let g:nerdtree_tabs_open_on_console_startup=1

"显示书签"
let NERDTreeShowBookmarks=1

" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
let g:NERDTreeIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ 'Ignored'   : '☒',
    \ "Unknown"   : "?"
    \ }
" }}}







"============================
" coc.nvim
" ===========================
" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <C-g> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


"-----------
" indentLine 缩进线配置
"-----------
let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_color_term = 239




"-----------
" ctags
"-----------
nmap <F9> :TagbarToggle<CR>
" 启动时自动focus
let g:tagbar_autofocus = 1
let g:tagbar_ctags_bin = 'ctags'
" for ruby, delete if you do not need
let g:tagbar_type_ruby = {
    \ 'kinds' : [
        \ 'm:modules',
        \ 'c:classes',
        \ 'd:describes',
        \ 'C:contexts',
        \ 'f:methods',
        \ 'F:singleton methods'
    \ ]
\ }




"=========================================
" 修改其中的内容去获得更好的体验。
"设置书签
let g:startify_bookmarks= [
            \ '~//Workspace/',
            \]
"起始页显示的列表长度
let g:startify_files_number = 10
"自动加载session
let g:startify_session_autoload = 1
"过滤列表，支持正则表达式
let g:startify_skiplist = [
       \ '^/tmp',
       \ ]
"自定义Header和Footer
let g:startify_custom_header = [
            \ '+------------------------------+',
            \ '|                              |',
            \ '|    Still waters run deep!    |',
            \ '|                              |',
            \ '+----------------+-------------+',
            \]
let g:startify_custom_footer = [
            \ '+------------------------------+',
            \ '|     Keep an open mind!       |',
            \ '+----------------+-------------+',
            \]






"=========================
" autocmd FileType java exec "CocDisable"

