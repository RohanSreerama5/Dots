set nocompatible              " be iMproved, required
filetype off                  " required
set encoding=UTF-8
set ignorecase
set smartcase
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" all plugin
"Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'

Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'

Plugin 'scrooloose/nerdtree'
Plugin 'vim-airline/vim-airline'
Plugin 'Raimondi/delimitMate'
Plugin 'morhetz/gruvbox'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'majutsushi/tagbar'
Plugin 'Yggdroot/indentLine'
Plugin 'neoclide/coc.nvim'
Plugin 'prettier/vim-prettier'
Plugin 'ryanoasis/vim-devicons'
Plugin 'airblade/vim-gitgutter'
Plugin 'easymotion/vim-easymotion'
Plugin 'skywind3000/asyncrun.vim'
Plugin 'frazrepo/vim-rainbow'
Plugin 'yegappan/taglist'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'dense-analysis/ale'
Plugin 'preservim/nerdcommenter'
"Plugin 'perservim/nerdcommenter'
" All of your Plugins must be added before the following line
call vundle#end()            " required
call glaive#Install()        " enable this line after the installation of glaive
filetype plugin indent on    " required

" custom setting
set mouse=a
set number
set encoding=utf-8
set backspace=indent,eol,start
set cursorline
set guioptions=
syntax on

" indent for global
set expandtab
set shiftwidth=4
set softtabstop=4
set autoindent

" indent for special file
autocmd FileType c,cpp setlocal expandtab shiftwidth=2 softtabstop=2 cindent 
autocmd FileType python setlocal expandtab shiftwidth=4 softtabstop=4 autoindent
let g:rainbow_active = 1
" setup for ycm
let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py'
let g:ycm_python_binary_path = 'python'
let g:ycm_complete_in_comments = 1
let g:ycm_autoclose_preview_window_after_completion = 1
let g:ycm_autoclose_preview_window_after_insertion = 1
let g:ycm_semantic_triggers =  {
  \ 'c' : ['re!\w{2}'],
  \ 'cpp' : ['re!\w{2}'],
  \ 'python' : ['re!\w{2}'],
  \ }

" setup for syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 0
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0
let g:syntastic_python_checkers = ['flake8']

" autoformat
augroup autoformat_settings
  autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType python AutoFormatBuffer yapf
augroup END
" use google style for clang-format
Glaive codefmt clang_format_style='google'

" open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

map <silent> <F5> : NERDTreeToggle<CR>

" setup for gruvbox
set t_Co=256
set background=dark
colorscheme gruvbox
" let g:gruvbox_contrast_dark = 'soft'

" setup for ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" setup for tagbar
nmap <F8> :TagbarToggle<CR>

" setup for indent line
let g:indentLine_char = '│'
set tags=./tags,tags;$HOME
"source ~/cscope_maps.vim

" if hidden is not set, TextEdit might fail.
set hidden
"
" " Some servers have issues with backup files, see #649
set nobackup
set nowritebackup
"
" " Better display for messages
set cmdheight=2
"
" " You will have bad experience for diagnostic messages when it's default
" 4000.
set updatetime=300
"
" " don't give |ins-completion-menu| messages.
set shortmess+=c
"
" " always show signcolumns
set signcolumn=yes
"
" " Use tab for trigger completion with characters ahead and navigate.
" " Use command ':verbose imap <tab>' to make sure tab is not mapped by other
" plugin.
inoremap <silent><expr> <TAB>
    \ pumvisible() ? "\<C-n>" :
    \ <SID>check_back_space() ? "\<TAB>" :
    \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
"
"                       " Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()
"
"                       " Use <cr> to confirm completion, `<C-g>u` means break
"                       undo chain at current position.
"                       " Coc only does snippet and additional edit on
"                       confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"
"                       " Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)
"
"                       " Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
"
"                       " Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
"
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
"
"                                     " Highlight symbol under cursor on
"                                     CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')
"
"                                     " Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)
"
"                                     " Remap for format selected regi
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
"
augroup mygroup
 autocmd!
"                                         " Setup formatexpr specified
"                                         filetype(s).
 autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"                                             " Update signature help on jump
"                                             placeholder
 autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
"
"                                               " Remap for do codeAction of
"                                               selected region, ex:
"                                               `<leader>aap` for current
"                                               paragraph
xmap <leader> <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)
"
"                                               " Remap for do codeAction of
"                                               current line
nmap <leader>ac <Plug>(coc-codeaction)
"                                               " Fix autofix problem of
"                                               current line
nmap <leader>qf <Plug>(coc-fix-current)
"
"                                               " Use <tab> for select
"                                               selections ranges, needs
"                                               server support, like:
"                                               coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)
"
"                                               " Use `:Format` to format
"                                               current buffer
command! -nargs=0 Format :call CocAction('format')
"
"                                               " Use `:Fold` to fold current
"                                               buffer
command! -nargs=? Fold :call CocAction('fold', <f-args>)
"
"                                               " use `:OR` for organize
"                                               import of current buffer
command! -nargs=0 OR   :call CocAction('runCommand','editor.action.organizeImport')
"
"                                               " Add status line support, for
"                                               integration with other plugin,
"                                               checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
"
"                                               " Using CocList
"                                               " Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
"                                               " Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
"                                               " Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
"                                               " Find symbol of current
"                                               document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
"                                               " Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
"                                               " Do default action for next
"                                               item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
"                                               " Do default action for
"                                               previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
"                                               " Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>
"
