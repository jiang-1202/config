call plug#begin()
    Plug 'morhetz/gruvbox'                              "主题
    Plug 'prabirshrestha/vim-lsp'                       "lsp
    Plug 'mattn/vim-lsp-settings'                       "lsp安装服务
    Plug 'prabirshrestha/asyncomplete.vim'              "自动补全
    Plug 'prabirshrestha/asyncomplete-lsp.vim'          "自动补全lsp
    Plug 'scrooloose/nerdtree'                          "文件管理
    Plug 'voldikss/vim-translator'                      "翻译插件
call plug#end()

set smartindent                 "智能缩进
set tabstop=4        	        "按下tab等于4个空格
set autoindent 		            "设置缩进规则根据上一行判断
set expandtab	    	        "自动将tab转空格
set softtabstop=4               "设置使用退格键删除多个空格时的宽度
set shiftwidth=4                "设定自动缩进的宽度。
set nobackup                    "不需要备份
set noswapfile                  "禁止生成临时文件
set noautochdir                 "禁止生成.us 文件
set nobackup                    "不创建备份文件
set background=dark  	        "主题黑色模式
set clipboard=unnamed           "优化粘贴板
set nowrap                      "不让太长的一行折行显示
set number                      "显示行号
set relativenumber              "显示光标当前所在行号,并上下计数
set cursorline                  "高亮光标所在行
set foldmethod=indent           "代码折叠
set completeopt=menu            "禁用弹窗下方的窗口
set guioptions=                 "禁用gui版本的滚动条
set splitright                  "设置左右分割窗口时，新窗口出现在右侧
set splitbelow                  "置水平分割窗口时，新窗口出现在底部
"set termguicolors

"=================================================gruvbox====================================================
let g:gruvbox_contrast_dark="hard" "黑色程度
colorscheme gruvbox                "设置主题 

"=================================================translator====================================================
nmap <C-c> <Plug>TranslateW         
"vmap <C-c> <Plug>TranslateWV
vmap <C-c> :TranslateW<CR>

"=================================================nerdtree====================================================
nnoremap <C-f> :NERDTreeToggle<CR>  

"=================================================lsp====================================================
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nmap <buffer> gd <plug>(lsp-definition)
    nmap <buffer> gs <plug>(lsp-document-symbol-search)
    nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
    nmap <buffer> gr <plug>(lsp-references)
    nmap <buffer> gi <plug>(lsp-implementation)
    nmap <buffer> gt <plug>(lsp-type-definition)
    nmap <buffer> gn <plug>(lsp-rename)
    nmap <buffer> gE <plug>(lsp-Document-diagnostic)
    nmap <buffer> ge <plug>(lsp-next-diagnostic)
    nmap <buffer> K <plug>(lsp-hover)
    let g:lsp_format_sync_timeout = 100
    autocmd! BufWritePre *.rs,*.go call execute('LspDocumentFormatSync')
endfunction
augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_signature_help_enabled = 0
let g:lsp_diagnostics_float_cursor = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_signs_warning = {'text': '!'}
let g:lsp_diagnostics_signs_error = {'text': '✗'}
let g:lsp_diagnostics_signs_hint = {'text': '?'}

"=================================================asyncomplete====================================================
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
let g:asyncomplete_auto_popup = 0
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
