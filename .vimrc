call plug#begin()
    Plug 'morhetz/gruvbox'                              "主题
    Plug 'voldikss/vim-translator'                      "翻译插件
    Plug 'scrooloose/nerdtree'                          "文件管理
    Plug 'prabirshrestha/vim-lsp'                       "lsp
    Plug 'mattn/vim-lsp-settings'                       "lsp安装服务
    Plug 'prabirshrestha/asyncomplete.vim'              "自动补全
    Plug 'prabirshrestha/asyncomplete-lsp.vim'          "自动补全lsp
call plug#end()

"=================================================options====================================================
set incsearch
set hlsearch
set relativenumber              "显示光标当前所在行号,并上下计数
set smartindent                 "智能缩进
set noautochdir                 "禁止生成.us 文件
set autoindent 		            "设置缩进规则根据上一行判断
set cursorline                  "高亮光标所在行
set splitright                  "设置左右分割窗口时，新窗口出现在右侧
set splitbelow                  "置水平分割窗口时，新窗口出现在底部
set noswapfile                  "禁止生成临时文件
set expandtab	    	        "自动将tab转空格
set nobackup                    "不创建备份文件
set nowrap                      "不让太长的一行折行显示
set number                      "显示行号
set clipboard=unnamed           "优化粘贴板
set foldmethod=indent           "代码折叠
set completeopt=menu            "禁用弹窗下方的窗口
set background=dark  	        "主题黑色模式
set softtabstop=4               "设置使用退格键删除多个空格时的宽度
set shiftwidth=4                "设定自动缩进的宽度。
set tabstop=4        	        "按下tab等于4个空格
"set termguicolors               "颜色加强

"=================================================translator====================================================
nmap <C-c> :TranslateW<CR>
vmap <C-c> :TranslateW<CR>
"=================================================nerdtree====================================================
nnoremap <C-f> :NERDTreeToggle<CR>  

"=================================================gruvbox====================================================
let g:gruvbox_contrast_dark="hard" "黑色程度
colorscheme gruvbox                "设置主题 

"=================================================lsp====================================================
let g:lsp_signature_help_enabled = 0
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_diagnostics_signs_warning = {'text': '!'}
let g:lsp_diagnostics_signs_error = {'text': '✗'}
let g:lsp_diagnostics_signs_hint = {'text': '?'}
let g:lsp_async_completion = 1

function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    let g:lsp_format_sync_timeout = 100
    nmap gc :LspCallHierarchyIncoming<CR>
    nmap gb :LspWorkspaceSymbolSearch<CR>
    nmap gl :LspDocumentDiagnostics<CR>
    nmap gs :LspWorkspaceSymbol<CR>
    nmap gk :LspPeekDefinition<CR>
    nmap gf :LspDocumentFormat<CR>
    nmap ge :LspNextDiagnostic<CR>
    nmap gj :LspCodeAction<CR>
    nmap gd :LspDefinition<CR>
    nmap gn :LspRename<CR>
    nmap K  :LspHover<CR>
endfunction

augroup lsp_install
    au!
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

"=================================================asyncomplete====================================================

" 检查前一个字符是否是空格或空
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

let g:asyncomplete_auto_popup = 0
" 定义一个函数用于切换自动弹出补全菜单的状态
function! ToggleAutoPopup()
    let g:asyncomplete_auto_popup = !g:asyncomplete_auto_popup
    if g:asyncomplete_auto_popup
        echo "开启:自动提示"
    else
        echo "关闭:自动提示"
    endif
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ asyncomplete#force_refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr><cr> pumvisible() ? asyncomplete#close_popup() : "\<cr>"
nmap <C-p> : call ToggleAutoPopup()<CR>


cnoreabbrev gorun !go run .
