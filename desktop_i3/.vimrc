" general config settings
set nocompatible               " be iMproved
filetype off                   " required!
set exrc
set secure
set rtp+=~/.vim/bundle/vundle/
"tabs
set nu
syntax on
set tabstop=2
set shiftwidth=2
set expandtab
set colorcolumn=110
highlight ColorColumn ctermbg = darkgrey
call vundle#rc()
" My Bundles here:
"
" original repos on github
" Bundle 'Lokaltog/vim-easymotion'
" Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
" Bundle 'tpope/vim-rails.git'
" vim-scripts repos
"Plugin 'Yggdroot/indentLine'
"
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-repeat'
Bundle 'kien/ctrlp.vim'
Plugin 'godlygeek/tabular'
Bundle 'plasticboy/vim-markdown'
Bundle 'sjl/gundo.vim'
Plugin 'Valloric/YouCompleteMe'
Bundle 'scrooloose/syntastic'
Bundle 'scrooloose/nerdtree'
Bundle 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'
Plugin 'Raimondi/delimitMate'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rdnetto/YCM-Generator'
Bundle 'flazz/vim-colorschemes'
Bundle 'vim-scripts/restore_view.vim'
Bundle 'klen/python-mode'

" Bundle 'L9'
" Bundle 'FuzzyFinder'
" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
" ...
filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
" Track the engine.

"Hopefully this resolves all issues with UltiSnips and YouCompleteMe

function! g:UltiSnips_Complete()
    call UltiSnips#ExpandSnippet()
    if g:ulti_expand_res == 0
        if pumvisible()
            return "\<C-n>"
        else
            call UltiSnips#JumpForwards()
            if g:ulti_jump_forwards_res == 0
               return "\<TAB>"
            endif
        endif
    endif
    return ""
endfunction

au BufEnter * exec "inoremap <silent> " . g:UltiSnipsExpandTrigger . " <C-R>=g:UltiSnips_Complete()<cr>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsListSnippets="<c-e>"
" this mapping Enter key to <C-y> to chose the current highlight item
" and close the selection list, same as other IDEs.
" CONFLICT with some plugins like tpope/Endwise


" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsSnippetDirectories=["UltiSnips", "UltiSnippets"]
let g:UltiSnipsEditSplit="vertical"

" Syntastic Config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 1
let g:syntastic_enable_highlighting = 1
let g:syntastic_mode = "active"


" vertical line indentation
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#09AA08'
let g:indentLine_char = '│'
"Markdown Settings
let g:vim_markdown_fontmatter=1


"folding settings
set foldmethod=manual
set fdm=manual
set foldnestmax=10
set foldlevel=1

"maps
nmap <leader>d :NERDTreeToggle<CR>
"restore_view
set viewoptions=cursor,folds,slash,unix
let g:skipview_files= ['*\.vim']

"Vim Airline
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1

" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '▶'
let g:airline_right_sep = '«'
let g:airline_right_sep = '◀'

" airline symbols
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

"ColorStuff
let g:solarized_termtrans = 1
colorscheme 0x7A69_dark

" 256-jungle
"slate
"OUTdelek
"elflord
"OUTholodark
"OUTron
"vividchalk
"OUTzelner
"desert

