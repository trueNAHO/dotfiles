" vim: ft=vim fdm=marker et sts=4 sw=4 ts=8 tw=80

"{{{ ---- NEOVIM ----

"             ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
"             ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
"             ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
"             ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
"             ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
"             ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
"                                       Tool: http://patorjk.com/software/taag/
"                                       Font: ANSI Shadow

"                                   ███████
"                               ████       ████
"                             ██   █       █   ██
"                             ██   ██      █   ██
"                           ██     █ █     █     ██
"                           ██     █  █    █     ██ GitHub:
"                           ██     █   █   █     ██ https://github.com/trueNAHO
"                           ██     █    █  █     ██
"                             ██   █     █ █   ██
"                             ██   █      ██   ██
"                               ████       ████
"                                   ███████

" References:
    " https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/
    " https://github.com/VonHeikemen/dotfiles/tree/master/my-configs/neovim




"}}}

"{{{ Initialisation
"------------------------------------------------------------------------------
"                               Initialisation
"------------------------------------------------------------------------------

"{{{ vim-plug
"--------------------------------- vim-plug -----------------------------------

" Making sure 'vim-plug' is installed. If not, it will do so.
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
      \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"}}}

"{{{ Backup, swap and undo files
"------------------------ Backup, swap and undo files -------------------------

" Making sure directories into which we are going to save backup, swap and undo
" files exist (directory for those files is '~/.cache/nvim/'). If they don't
" exist, they will be created.
if empty(glob('~/.cache/nvim/backup-files')) ||
    \ empty(glob('~/.cache/nvim/swap-files')) ||
    \ empty(glob('~/.cache/nvim/undo-files'))
  !mkdir ~/.cache/nvim/backup-files
        \ ~/.cache/nvim/swap-files
        \ ~/.cache/nvim/undo-files
endif

" Now that the directories for saving backup, swap and undo files exist, we can
" declare those folders to be used for their respective tasks. Note for
" possible file collisions (directly from the help page): If a directory ends
" in two path separators '//', the swap file name will be built from the
" complete path to the file with all path separators changed to percent '%'
" signs.
set backup
set backupdir=~/.cache/nvim/backup-files//
set swapfile
set directory=~/.cache/nvim/swap-files//
set undofile
set undodir=~/.cache/nvim/undo-files//

"}}}

"}}}

"{{{ Functions
"------------------------------------------------------------------------------
"                                  Functions
"------------------------------------------------------------------------------

"{{{ CleanFile
"--------------------------------- CleanFile ----------------------------------

function! CleanFile(selectedOptions, maxCharMatch, is_nohighlight)
    let l:selectedOptions = type(a:selectedOptions) == 3 ?
                \ a:selectedOptions :
                \ [a:selectedOptions]
    let l:maxCharMatch = type(a:maxCharMatch) == 0 ?
                \ a:maxCharMatch :
                \ ''
    let l:commentstr = &commentstring!='/*%s*/' ?
                \ substitute(&commentstring,'\s*%s.*$','','') : ''
    " 'all_options':
        " 0. Remove trailing white spaces.
        " 1. Remove content of line, if it consits only of '&commentstring'.
        " 2. Same as '1.' but deletes line completely instead of just content.
        " 3. Remove ultiple consecutive white spaces (excluding line
        "    indentation) or consecutive empty newlines.
        " 4. Remove white spaces between certain types of brackets and its
        "    following or preceding non-empty content (Also works for spaces
        "    BEFORE dots).
    let l:all_options = [
                \ '%s/\s\+$//ge',
                \ '%s/^\s*' . l:commentstr[0] . '\{,' . l:maxCharMatch . '}\s*$//e',
                \ '%s/^\s*' . l:commentstr[0] . '\{,' . l:maxCharMatch . '}\s*\n//e',
                \ '%s/\v(\S+)(\s)\s+\|^\n$/\1\2/gec',
                \ '%s/\v(()([([{<])(\s+)\|(\s+)([)\]}>.])())/\3\6/gec',
                \ ]
    for option in l:selectedOptions
        exec l:all_options[option]
    endfor
    if a:is_nohighlight == 1
        exec 'nohls'
    endif
endfunction

"}}}

"{{{ Comments
"--------------------------------- Comments -----------------------------------

"{{{ CommentYesNoToggle
function! CommentYesNoToggle(yesNoToggle, default_commentstr, len_commentstr)

    " Defining variables. Note potential default value for 'l:commentstr' and
    " that its last character gets extended to reach a lenght of
    " 'a:len_commentstr'.
    let l:commentstr = &commentstring!='/*%s*/' ?
                \ substitute(&commentstring,'\s*%s.*$','','') :
                \ a:default_commentstr
    let l:commentstr .= repeat(
                \ l:commentstr[len(l:commentstr)-1],
                \ a:len_commentstr - len(l:commentstr)
                \ )
    let l:curpos_start = getcurpos()

    " Situational variables. Note to use '<Esc>' before calling this function,
    " when in visual mode.
    exec "'<"
    let l:lnum_start = getcurpos()[1]
    exec "'>"
    let l:lnum_end = getcurpos()[1]

    " Reading selected area.
    let l:replacement = getline(l:lnum_start, l:lnum_end)

    " 1. If 'a:yesNoToggle' is 'y', then insert (after potential indentation)
    "    'l:commentstr' at the beginning of each line.
    " 2. If 'a:yesNoToggle' is 'n', then remove the first occurrence of
    "    'l:commentstr' of each line.
    " 3. If 'a:yesNoToggle' is 't', then insert (after potential indentaion)
    "    'l:commentstr' at the beginning of each line when no 'l:commentstr' is
    "    present yet, and remove the first occurrence of 'l:commentstr' of each
    "    line when l':commentstr' is already present.
    " 4. If 'a:yesNoToggle' is anything else, then 'l:commentstr' will not be
    "    modified and the output will not differ from input!!
    if a:yesNoToggle == 'y'
        call map(
                    \ l:replacement,
                    \ {
                        \ _,val ->
                            \ substitute(val,'^\s*'.l:commentstr,'','')==val &&
                                \ match(val, '^\s*$') == -1 ?
                            \ substitute(val, '^\(\s*\).*$', '\1', '') .
                                \ l:commentstr .
                                \ substitute(val, '^\s*', '', '') :
                            \ val
                        \ }
                    \ )
    elseif a:yesNoToggle == 'n'
        call map(
                    \ l:replacement,
                    \ {
                        \ _,val ->
                            \ substitute(val,'^\s*'.l:commentstr,'','')==val &&
                                \ match(val, '^\s*$') == -1 ?
                            \ val :
                            \ substitute(
                                \ val,
                                \ '^\(\s*\)' .
                                    \ l:commentstr .
                                    \ '\(.*$\)',
                                \ '\1\2',
                                \ ''
                                \ )
                        \ }
                    \ )
    elseif a:yesNoToggle == 't'
        call map(
                    \ l:replacement,
                    \ {
                        \ _,val ->
                            \ substitute(val,'^\s*'.l:commentstr,'','')==val &&
                                \ match(val, '^\s*$') == -1 ?
                            \ substitute(val, '^\(\s*\).*$', '\1', '') .
                                \ l:commentstr .
                                \ substitute(val, '^\s*', '', '') :
                            \ substitute(
                                \ val,
                                \ '^\(\s*\)' .
                                    \ l:commentstr .
                                    \ '\(.*$\)',
                                \ '\1\2',
                                \ ''
                                \ )
                        \ }
                    \ )
    endif

    " Producing output and positioning cursor to initial position.
    call nvim_buf_set_lines(0, l:lnum_start-1, l:lnum_end, 0, l:replacement)
    call setpos('.', [0, l:curpos_start[1], l:curpos_start[2]])

endfunction

"}}}

"}}}

"{{{ Folds
"----------------------------------- Folds ------------------------------------

"{{{ CustomFoldText
function! CustomFoldText(fillchar, foldsign, minimumFoldLevelToShow,
                       \ adjust_fillcharCount)

    " Defining variables. Note potential default value for 'l:textwidth'.
    let l:textwidth = &textwidth > 0 ? &textwidth : 80
    let l:foldedlineNum = v:foldend - v:foldstart
    let l:foldlevel = foldlevel(v:foldstart) != a:minimumFoldLevelToShow ?
                \ foldlevel(v:foldstart) .
                    \ ' ' .
                    \ a:foldsign .
                    \ ' ' :
                \ ''
    let l:foldmarker_start = split(&foldmarker, ',')[0]
    let l:foldindent = substitute(getline(v:foldstart),'^\(\s*\).*$','\1','')
    let l:linetext_left = l:foldindent .
                \ a:foldsign .
                \ ' ' .
                \ l:foldlevel .
                \ substitute(
                    \ getline(v:foldstart),
                    \ '\(^.\{-}\s*' .
                        \ l:foldmarker_start .
                        \ '\d*\s*\|^.\{-}\s*\(.\{-}\)\s*' .
                        \ l:foldmarker_start .
                        \ '$\)',
                    \ '\2',
                    \ ''
                    \ ) .
                \ ' '
    let l:linetext_right = ' [' . l:foldedlineNum . ' L]'

    " Computing amount of 'fillchar' to be used. In case 'foldsign' length is
    " computed incorrectly (maybe due to special icons as with Nerd Font)
    " 'a:adjust_fillcharCount' will come in handy.
    let l:fillcharCount = l:textwidth -
                \ len(l:linetext_left) - len(l:linetext_right) +
                \ a:adjust_fillcharCount

    return l:linetext_left.repeat(a:fillchar,l:fillcharCount).l:linetext_right

endfunction

"}}}

"}}}

"{{{ Headers
"---------------------------------- Headers -----------------------------------

"{{{ HeaderInit

function! HeaderInit()
    let l:commentstr = &commentstring!='/*%s*/' ?
                \ substitute(&commentstring,'\s*%s.*$','','') : ''
    exec "normal S" . l:commentstr . "{{{"
    exec "normal 3o"
    exec "normal o" . l:commentstr .
"}}}"
    exec "normal 2k"
endfunction


"}}}

"{{{ HeaderRead
function! HeaderRead(filePath, commentHandling, beforeCurMove, lnum_movedown,
                   \ afterCurMove)

    " Defining variables. Note potential default values for 'l:afterCurMove'
    " and 'l:commentstring'.
    let l:afterCurMove = a:afterCurMove!='' ?
                \ 'normal ' . a:afterCurMove : ''
    let l:commentstr = &commentstring!='/*%s*/' ?
                \ substitute(&commentstring,'\s*%s.*$','','') : ''
    let l:lnum_start = getcurpos()[1]
    let l:linesToCreate = getbufinfo(bufname())[0]['linecount'] -
                \ l:lnum_start - a:lnum_movedown

    " Reading text from 'a:filePath' and getting further information.
    exec 'read '.fnameescape(a:filePath).'|normal '.a:beforeCurMove.'`]'
    let l:lnum_end = getcurpos()[1]
    let l:replacement = getline(l:lnum_start+1, l:lnum_end)

    " 1. If 'a:commentHandling' is 'r', then the start of each line will be
    "    replaced with 'l:commentstr'.
    " 2. If 'a:commentHandling' is 'i', then 'l:commentstr' will be inserted at
    "    the start of each line.
    " 3. If 'a:commentHandling' is anything else, then 'l:commentstr' will not
    "    be used for final output string and is simply skipped.
    if a:commentHandling == 'r'
        call map(
                    \ l:replacement,
                    \ "substitute(
                        \ v:val,
                        \ '^' . substitute(l:commentstr, '.', '\.', 'g'),
                        \ l:commentstr,
                        \ ''
                        \ )"
                    \)
    elseif a:commentHandling == 'i'
        call map(l:replacement, "l:commentstr . v:val")
    endif

    " Adding necessary lines to assure proper cursor movement.
    while l:linesToCreate < 0
        let l:linesToCreate += 1
        let l:replacement += ['']
    endwhile

    " Producing output and positioning cursor 'lnum_movedown' many lines below,
    " as well as executing 'l:afterCurMove'.
    call nvim_buf_set_lines(0, l:lnum_start, l:lnum_end, 0, l:replacement)
    call setpos('.', [0, getcurpos()[1] + a:lnum_movedown, 0])
    exec l:afterCurMove

endfunction

"}}}

"{{{ Header1
function! Header1(bannerChar, fillChar, is_createFold, is_foldIndent,
                \ linesAfterBanner, lnum_movedown, afterCurMove)

    " Defining variables. Note potential default values for 'l:textwidth' and
    " 'l:commentstring'.
    let l:afterCurMove = a:afterCurMove!='' ?
                \ 'normal ' . a:afterCurMove : ''
    let l:textwidth = &textwidth > 0 ? &textwidth : 80
    let l:commentstr = &commentstring!='/*%s*/' ?
                \ substitute(&commentstring,'\s*%s.*$','','') : ''

    " Situational variables.
    let l:lnum = getcurpos()[1]
    let l:linesToCreate = getbufinfo(bufname())[0]['linecount'] -
                \ l:lnum - a:lnum_movedown

    " Adding necessary lines.
    let l:addedLines = []
    let l:linesToAdd = a:linesAfterBanner
    while l:linesToCreate < 0
        let l:linesToCreate += 1
        let l:addedLines += ['']
    endwhile
    while l:linesToAdd > 0
        let l:linesToAdd -= 1
        let l:addedLines += ['']
    endwhile
    let l:addedLines = l:addedLines[
                \ :max([a:linesAfterBanner, a:lnum_movedown]) - 1
                \ ]

    " Reading line under cursor and modifying it for final output.
    let l:get_text = substitute(getline(l:lnum), '^\s*\|\s*$', '', 'g')
    let l:textindent = a:is_foldIndent==1 ?
                \ substitute(getline(l:lnum),'^\(\s*\).*$','\1','') : ''
    let l:fillCharCountLeft = float2nr(
                \ (l:textwidth - len(l:get_text) - len(textindent)) / 2
                \ )
    let l:text = repeat(a:fillChar, l:fillCharCountLeft + len(l:textindent)) .
                \ l:get_text
    let l:seperator = l:textindent . repeat(
                    \ a:bannerChar, l:textwidth - len(l:textindent)
                    \ )
    let l:replacement = [l:seperator, l:text, l:seperator] + l:addedLines
    call map(
                \ l:replacement,
                \ "substitute(
                    \ v:val,
                    \ '^' . l:textindent .
                        \ substitute(l:commentstr, '.', '\.', 'g'),
                    \ l:textindent . l:commentstr,
                    \ ''
                    \ )"
                \)

    " Potentially surrounding 'l:replacement' by the 'foldmarker'.
    if a:is_createFold == 1
        let l:replacement = [l:textindent . l:commentstr .
                    \ split(&foldmarker, ',')[0] . ' ' . l:get_text] +
                    \ l:replacement +
                    \ [l:textindent . l:commentstr . split(&foldmarker,',')[1]]
    endif

    " Producing output and positioning cursor 'lnum_movedown' many lines below.
    call nvim_buf_set_lines(0, l:lnum-1, l:lnum, 0, l:replacement)
    call setpos('.', [0, l:lnum + len(l:replacement)-1 + a:lnum_movedown,0])
    exec l:afterCurMove

endfunction

"}}}

"{{{ Header2
function! Header2(bannerChar, is_createFold, is_foldIndent, linesAfterBanner,
                \ lnum_movedown, afterCurMove)

    " Defining variables. Note potential default values for 'l:textwidth' and
    " 'l:commentstring'.
    let l:afterCurMove = a:afterCurMove!='' ?
                \ 'normal ' . a:afterCurMove : ''
    let l:textwidth = &textwidth > 0 ? &textwidth : 80
    let l:commentstr = &commentstring!='/*%s*/' ?
                \ substitute(&commentstring,'\s*%s.*$','','') : ''

    " Situational variables.
    let l:lnum = getcurpos()[1]
    let l:linesToCreate = getbufinfo(bufname())[0]['linecount'] -
                \ l:lnum - a:lnum_movedown

    " Adding necessary lines.
    let l:addedLines = []
    let l:linesToAdd = a:linesAfterBanner
    while l:linesToCreate < 0
        let l:linesToCreate += 1
        let l:addedLines += ['']
    endwhile
    while l:linesToAdd > 0
        let l:linesToAdd -= 1
        let l:addedLines += ['']
    endwhile
    let l:addedLines = l:addedLines[
                \ :max([a:linesAfterBanner, a:lnum_movedown]) - 1
                \ ]

    " Reading line under cursor and modifying it for final output string.
    let l:get_text = substitute(getline(l:lnum),'^\s*\|\s*$', '', 'g')
    let l:textindent = substitute(getline(l:lnum),'^\(\s*\).*$','\1','')
    let l:text = ' ' . l:get_text . ' '
    let l:fillCharCountLeft = float2nr(
                \ (l:textwidth - len(l:text) - len(textindent)) / 2
                \ )
    let l:fillCharCountRight = l:textwidth - len(l:text) -
                \ len(textindent) - l:fillCharCountLeft
    let l:replacement = [
                \ l:textindent . repeat(a:bannerChar, l:fillCharCountLeft) .
                \ l:text .
                \ repeat(a:bannerChar, l:fillCharCountRight)
                \ ] + l:addedLines
    call map(
                \ l:replacement,
                \ "substitute(
                    \ v:val,
                    \ '^' . l:textindent .
                        \ substitute(l:commentstr, '.', '\.', 'g'),
                    \ l:textindent . l:commentstr,
                    \ ''
                    \ )"
                \)

    " Potentially surrounding 'l:replacement' by the 'foldmarker'.
    if a:is_createFold == 1
        let l:replacement = [l:textindent . l:commentstr .
                    \ split(&foldmarker, ',')[0] . ' ' . l:get_text] +
                    \ l:replacement +
                    \ [l:textindent . l:commentstr . split(&foldmarker,',')[1]]
    endif

    " Producing output and positioning cursor 'lnum_movedown' many lines below.
    call nvim_buf_set_lines(0, l:lnum-1, l:lnum, 0, l:replacement)
    call setpos('.',[0,l:lnum + len(l:replacement)-1 + a:lnum_movedown,0])
    exec l:afterCurMove

endfunction

"}}}

"}}}


"}}}

"{{{ Plugins
"------------------------------------------------------------------------------
"                                   Plugins
"------------------------------------------------------------------------------

call plug#begin('~/.config/nvim/autoload/plugged')

"{{{ Functionality
"------------------------------- Functionality --------------------------------

    " telescope
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
    " undo tree
    Plug 'mbbill/undotree'
    """"" Vim + Git"
    """"Plug 'tpope/vim-fugitive'
    Plug 'neovim/nvim-lspconfig'

"}}}

"{{{ Design
"---------------------------------- Design ------------------------------------

    " color scheme
    Plug 'joshdick/onedark.vim'
    " airline
    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
    " treesitter
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    " color highlighter
    Plug 'norcalli/nvim-colorizer.lua'
    " Blue

"}}}

"{{{ Vim games
"--------------------------------- Vim games ----------------------------------

    """"Plug 'theprimeagen/vim-be-good' " vim practice game

"}}}

call plug#end()

"}}}

"{{{ Mappings
"------------------------------------------------------------------------------
"                                  Mappings
"------------------------------------------------------------------------------

let mapleader = ' '

"{{{ Reasonable defaults
"--------------------------- Reasonable defaults ------------------------------

" Cursor will be moved based on physical lines, not the actual lines (line
" number). This improves movement when dealing with wrapped lines.
nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <silent> ^ g^
nnoremap <silent> 0 g0
" Redo changes which were undone.
nnoremap U <C-r>
" Yank current line from current cursor position up to end of line.
nnoremap Y y$
" Change text without putting the text into register.
nnoremap c "_c
nnoremap C "_C
nnoremap cc "_cc
" Keep cursor centered during some movement.
""""nnoremap <C-u> <C-u><Esc>zz
""""nnoremap <C-d> <C-d><Esc>zz
nnoremap <C-b> <C-b><Esc>zz
nnoremap <C-f> <C-f><Esc>zz
nnoremap { {zz
nnoremap } }zz
nnoremap n nzzzv
nnoremap N Nzzzv
" Easier macro access.
nnoremap Q @q
" Indenting or dedenting lines will no more reset selected area ('visual' mode).
xnoremap < <gv
xnoremap > >gv
" Use sane regex expression (see `:h magic` for more info).
nnoremap / /\v

" Switch window focus using <ALT> and h,j,k,l.
nnoremap <M-h> <C-w>h
nnoremap <M-l> <C-w>l
nnoremap <M-j> <C-w>j
nnoremap <M-k> <C-w>k
" Resize windows size using <Alt-CTRL> and h,j,k,l.
nnoremap <M-C-h> <C-w><
nnoremap <M-C-l> <C-w>>
nnoremap <M-C-j> <C-W>-
nnoremap <M-C-k> <C-W>+
" Cycle to the previous or next buffer.
nnoremap <C-p> :bp<CR>
nnoremap <C-n> :bn<CR>

" Making <CTRL-c> the new <Esc> (giving <CTRL-c> more power than it originally
" had).
noremap <C-c> <Esc>
noremap! <C-c> <Esc>
" Quit built-in terminal by using <Esc>.
tnoremap <ESC> <C-\><C-n>
" Close auto-completion menu by using <Esc>.
inoremap <expr> <esc> ((pumvisible())?("\<C-e>"):("\<esc>"))

""""" Navigation in the location and quickfix list.
""""nnoremap [l :lprevious<CR>zv
""""nnoremap ]l :lnext<CR>zv
""""nnoremap [L :lfirst<CR>zv
""""nnoremap ]L :llast<CR>zv
""""nnoremap [q :cprevious<CR>zv
""""nnoremap ]q :cnext<CR>zv
""""nnoremap [Q :cfirst<CR>zv
""""nnoremap ]Q :clast<CR>zv

""""" Jump to matching pairs by using <Tab> ('normal' mode).
""""noremap <Tab> %
" Insert a space after current character using <Space><Space>.
nnoremap <Space><Space> a<Space><ESC>h
""""" Decrease indent level by using <Shift-Tab> ('insert' mode).
""""inoremap <S-Tab> <ESC><<i
""""" Close location list or quickfix list if they are present,
""""nnoremap<silent> \x :windo lclose <bar> cclose<CR>
""""" Close a buffer and switching to another buffer, do not close the window.
""""nnoremap <silent> \d :bprevious <bar> bdelete #<CR>
""""" Find and replace (like Sublime Text 3).
""""nnoremap <C-H> :%s/
""""xnoremap <C-H> :s/

""""" Turn the word under cursor to upper case ('insert' mode).
""""inoremap <silent> <c-u> <Esc>viwUea
""""" Turn the current word into title case ('insert' mode).
""""inoremap <silent> <c-t> <Esc>b~lea

""""" Quicker <Esc> in insert mode.
""""inoremap <silent> jk <Esc>
""""" Go to start or end of word using <Shift>h or <Shift>l.
""""noremap H b
""""noremap L w
""""" Go to start or end of line using <Shift>j or <Shift>k.
""""noremap J ^
""""noremap K $
""""" Move half screen up or down using <CTRL>j or <CTRL>k.
""""noremap <C-j> <C-d>
""""noremap <C-k> <C-u>

"}}}

"{{{ Map leader
"-------------------------------- Map leader ----------------------------------

""""" Faster save and quit.
""""nnoremap <silent> <leader>w :update<CR>
""""nnoremap <silent> <leader>q :x<CR>
""""" Quit all opened buffers.
""""nnoremap <silent> <leader>Q :qa<CR>

" Insert a blank line below or above current line (stable cursor).
noremap <leader>o m`o<Esc>S<Esc>``
noremap <leader>O m`O<Esc>S<Esc>``
" Remove line below or above current line (stable cursor).
noremap <leader>d m`jdd``
noremap <leader>D m`kdd``
" Paste text below or above current line (stable cursor),
noremap <leader>p m`o<ESC>p``
noremap <leader>P m`O<ESC>P``

" Toggle search highlighting
nnoremap <silent><expr> <Leader>hl (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"
" Change current working directory locally and print cwd after that.
nnoremap <silent> <leader>cd :lcd %:p:h<CR>:pwd<CR>
" Reselect the text that has just been pasted
nnoremap <leader>v `[V`]

" Toggle spell checking.
nnoremap <leader>s :set spell!<Enter>

" Different toggle options for 'formatoptions'. See here for more details:
" https://vi.stackexchange.com/questions/21808/is-there-a-toggle-set-option
nnoremap <expr> <leader>ta ":\<C-u>set fo".'+-'[&fo =~# 'a']."=a\<CR>"
nnoremap <expr> <leader>tt ":\<C-u>set fo".'+-'[&fo =~# 't']."=t\<CR>"
nnoremap <expr> <leader>tc ":\<C-u>set fo".'+-'[&fo =~# 'c']."=c\<CR>"

" Clean file from optentially undesired characters.
nnoremap <silent> <leader>cl m`:call CleanFile([0,1],10,1)<CR>``
nnoremap <silent> <leader>cL m`:call CleanFile(3,'',1)<CR>``
nnoremap <silent> <leader>Cl m`:call CleanFile(4,'',1)<CR>``

" Structure files by calling the following user-defined functions.
noremap <silent> <leader>h{ :call HeaderInit()<CR>
noremap <silent> <leader>hs :call HeaderRead('~/p/text-presets/shebang-start.txt','','kdd',0,'$')<CR>
noremap <silent> <leader>hm :call HeaderRead('~/p/text-presets/nvim_modeline.txt','i','',1,'')<CR>
noremap <silent> <leader>h0 :call HeaderRead('~/p/text-presets/NAHO-logo.txt','r','',2,'')<CR>
noremap <silent> <leader>h1 :call Header1('-',' ',0,1,1,0,'')<CR>
noremap <silent> <leader>H1 :call Header1('-',' ',1,1,1,0,'zo')<CR>
noremap <silent> <leader>h2 :call Header2('-',0,1,1,0,'')<CR>
noremap <silent> <leader>H2 :call Header2('-',1,1,1,0,'zo')<CR>

" Comment or uncomment selected area by calling the following user-defined
" functions. Note the '<Esc>' at the beginning of the macro. Without it, the
" function will be called for each line, which if inefficient.
xnoremap <silent> <leader>cy <Esc>:call CommentYesNoToggle('y','',4)<CR>
xnoremap <silent> <leader>cn <Esc>:call CommentYesNoToggle('n','',4)<CR>
xnoremap <silent> <leader>ct <Esc>:call CommentYesNoToggle('t','',4)<CR>

" Quickly edit and reload 'init.vim'.
nnoremap <silent> <leader>ev :edit $MYVIMRC<CR>
nnoremap <silent> <leader>sv :silent update $MYVIMRC <bar> source $MYVIMRC <bar>
    \ echomsg "Nvim config successfully reloaded!"<CR>

" create a table of current selection with the '|' as seperator
noremap <leader>t :'<,'>%!column -t -s "\|"<CR>

"}}}

"{{{ Command line
"------------------------------- Command line ---------------------------------

" Auto correct possible typos considering 'w', 'q' and 'h'.
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev H h

" Auto correct possible typos considering 'wa'.
cnoreabbrev aw wa
cnoreabbrev Wa wa
cnoreabbrev aW wa
cnoreabbrev WA wa
cnoreabbrev AW wa

" Auto correct possible typos considering 'wq'.
cnoreabbrev qw wq
""""cnoreabbrev Wq wq
command! Wq wq
cnoreabbrev qW wq
cnoreabbrev WQ wq
cnoreabbrev QW wq

" Auto correct possible typos considering 'xa'.
cnoreabbrev ax xa
cnoreabbrev Xa xa
cnoreabbrev aX xa
cnoreabbrev XA xa
cnoreabbrev AX xa

" Auto correct possible typos considering 'qa'.
cnoreabbrev aq qa
cnoreabbrev Qa qa
cnoreabbrev aQ qa
cnoreabbrev QA qa
cnoreabbrev AQ qa

"}}}

"{{{ Disable arrow keys
"---------------------------- Disable arrow keys ------------------------------

""""" Disables only a small portion of the arrow keys' functionalities.
""""noremap <Up> <nop>
""""noremap <Down> <nop>
""""noremap <Left> <nop>
""""noremap <Right> <nop>
""""noremap <C-Up> <nop>
""""noremap <C-Down> <nop>
""""noremap <C-Left> <nop>
""""noremap <C-Right> <nop>
""""inoremap <Up> <nop>
""""inoremap <Down> <nop>
""""inoremap <Left> <nop>
""""inoremap <Right> <nop>
""""inoremap <C-Up> <nop>
""""inoremap <C-Down> <nop>
""""inoremap <C-Left> <nop>
""""inoremap <C-Right> <nop>

"}}}

"}}}

"{{{ Settings
"------------------------------------------------------------------------------
"                                  Settings
"------------------------------------------------------------------------------

"{{{ Initialisation
"------------------------------ Initialisation --------------------------------

" checks if your terminal has 24-bit color support
if (has("termguicolors"))
    set termguicolors
    hi LineNr ctermbg=NONE guibg=NONE
endif

" For Neovim 0.1.3 and 0.1.4
let $NVIM_TUI_ENABLE_TRUE_COLOR=1

" Dictionary files for different systems
let g:MY_DICT = expand(stdpath('config') . '/dict/words')
let &dictionary = &dictionary . ',' . g:MY_DICT

" Use mouse to select and resize windows, etc.
if has('mouse')
    set mouse=nv            " Enable mouse in several mode
    set mousemodel=popup    " Set the behaviour of mouse
endif

"}}}

"{{{ Spacing
"---------------------------------- Spacing -----------------------------------

" Good auto indent
set autoindent
" Set a ruler at column 80, see https://goo.gl/vEkF5i
set colorcolumn=+1
" Show current line where the cursor is
set cursorline
" Describes how automatic formatting is to be done.
set formatoptions=cqwanmM1jp
" treat dash separated words as a word text object
set iskeyword+=-
" Break line at predefined characters
set linebreak
" Minimum lines to keep above and below cursor when scrolling
set scrolloff=3
" Character to show before the lines that have been soft-wrapped
set breakindent breakindentopt=shift:4 showbreak=↪\  "" text to preserve space
" Tab settings
set expandtab
set shiftround
set shiftwidth=4
set softtabstop=4
" Makes indenting smart
set smartindent
" Text after this column number is not highlighted
set synmaxcol=200
" when you typing something longer than 80 columns, Vim will automatically
" insert a newline character.
set textwidth=80

"}}}

"{{{ Design
"---------------------------------- Design ------------------------------------

" So that I can see `` in markdown files
set conceallevel=0
" Using {{{ and }}} as markers (by default) for folding. Using self-made
" function for 'foldtext'. Changing fill characters for folding, so there are no
" garbage characters.
set fillchars=fold:\ ,vert:\| foldmethod=marker foldtext=CustomFoldText('.','',0,4)
" Required to keep multiple buffers open multiple buffers
set hidden
" Do not show mode on command line since vim-airline can show it
set noshowmode
" Settings for pop-up menu
set pumheight=15 " Maximum number of items to show in pop-up menu
set pumblend=5 " Pesudo blend effect for pop-up menu
" Show relative line number
set relativenumber
" Show the cursor position all the time
set ruler
" Do not show 'match xx of xx' and other messages during auto-completion
set shortmess+=c
" Always show tabs
set showtabline=2
" Split window below/right when creating horizontal/vertical windows
set splitbelow splitright
" Show host name, full path of file and last-mod time on the window title.
" The meaning of the format str for strftime can be found in
" http://tinyurl.com/l9nuj4a. The function to get lastmod time is drawn from
" http://tinyurl.com/yxd23vo8
set title
set titlestring=
set titlestring+=%(%{hostname()}\ \ %)
set titlestring+=%(%{expand('%:p')}\ \ %)
set titlestring+=%{strftime('%Y-%m-%d\ %H:%M',getftime(expand('%')))}
" Enable syntax
syntax on

"}}}

"{{{ Technical stuff
"---------------------------- Technical stuff ---------------------------------

" Auto-write the file at certain points.
set autowrite
" Clipboard settings, always use clipboard for all delete, yank, change, put
" operation, see https://goo.gl/YAHBbJ
set clipboard+=unnamedplus
" Completion behaviour
set completeopt+=noinsert    " Auto select the first completion entry
set completeopt+=menuone     " Show menu even if there is only one item
set completeopt-=preview     " Disable the preview window
" The mode in which cursor line text can be concealed
set concealcursor=nc
" Ignore case in general, but become case-sensitive when uppercase is present
set ignorecase smartcase
" The way to show the result of substitution in real time for preview
set inccommand=nosplit
" Use list mode and customized listchars
set list listchars=tab:▸\ ,extends:❯,precedes:❮,nbsp:+
" Set matching pairs of characters and highlight matching brackets
set matchpairs+=<:>,「:」
" Do not add two space after a period when joining lines or formatting texts,
" see https://tinyurl.com/y3yy9kov
set nojoinspaces
" Paste mode toggle, it seems that Neovim's bracketed paste mode
" does not work very well for nvim-qt, so we use good-old paste mode
set pastetoggle=<F12>
" Spell languages (en: English, de, German, fr, French)
set spelllang=en
" Tilde (~) is an operator, thus must be followed by motions like `e` or `w`.
set tildeop
" Time in milliseconds to wait for a mapped sequence to complete,
" see https://goo.gl/vHvyu8 for more info
set timeoutlen=500
" For Cursor Hold events
set updatetime=300
" Virtual edit is useful for visual block edit
set virtualedit=block
" Do not use visual and error bells
set visualbell noerrorbells
" List all items and start selecting matches in cmd completion
set wildmenu
set wildmode=longest,list,full
" Make a backup before overwriting a file.
set writebackup

"}}}

"{{{ File type
"------------------------------ File type -------------------------------------

" Script encoding
scriptencoding utf-8
" Scan files given by `dictionary` option
set complete+=k,kspell complete-=w complete-=b complete-=u complete-=t
" Ask for confirmation when handling unsaved or read-only files
set confirm
" File and script encoding settings for vim
set fileencoding=utf-8
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" File formats to use for new files
set fileformats=unix,dos
" The number of command and search history to keep
set history=500
" Ignore certain files and folders when globing
set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.pyc
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.pdf

"}}}

"}}}

"{{{ Auto commands
"------------------------------------------------------------------------------
"                                Auto commands
"------------------------------------------------------------------------------

"{{{ https://gist.github.com/jdhao/d592ba03a8862628f31cba5144ea04c2
"------ https://gist.github.com/jdhao/d592ba03a8862628f31cba5144ea04c2 --------

" Do not use smart case in command line mode,
" extracted from https://goo.gl/vCTYdK
augroup dynamic_smartcase
    autocmd!
    autocmd CmdLineEnter : set nosmartcase
    autocmd CmdLineLeave : set smartcase
augroup END

" Set text width for text file types
augroup text_file_width
    autocmd!
    " Sometimes, automatic file type detection is not right, so we need to
    " detect the file type based on the file extensions
    autocmd BufNewFile,BufRead *.md,*.MD,*.markdown setlocal textwidth=80
augroup END

augroup term_settings
    autocmd!
    " Do not use number and relative number for terminal inside nvim
    autocmd TermOpen * setlocal norelativenumber nonumber
    " Go to insert mode by default to start typing command
    autocmd TermOpen * startinsert
augroup END

" More accurate syntax highlighting? (see `:h syn-sync`)
augroup accurate_syn_highlight
    autocmd!
    autocmd BufEnter * :syntax sync fromstart
augroup END

" Return to last edit position when opening a file
augroup resume_edit_position
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ | execute "normal! g`\"zvzz"
        \ | endif
augroup END

" Display a message when the current file is not in UTF-8 format.
" Note that we need to use `unsilent` command here because of this issue:
" https://github.com/vim/vim/issues/4379
augroup non_utf8_file_warn
    autocmd!
    autocmd BufRead * if &fileencoding != 'utf-8'
                \ | unsilent echomsg 'File not in UTF-8 format!' | endif
augroup END

" Automatically reload the file if it is changed outside of Nvim, see
" https://unix.stackexchange.com/a/383044/221410. It seems that `checktime`
" command does not work in command line. We need to check if we are in command
" line before executing this command. See also http://tinyurl.com/y6av4sy9.
augroup auto_read
    autocmd!
    autocmd FocusGained,BufEnter,CursorHold,CursorHoldI *
                \ if mode() == 'n' && getcmdwintype() == '' | checktime | endif
    autocmd FileChangedShellPost * echohl WarningMsg
                \ | echo "File changed on disk. Buffer reloaded!" | echohl None
augroup END

"}}}

"}}}

"{{{ Plugin settings
"------------------------------------------------------------------------------
"                               Plugin settings
"------------------------------------------------------------------------------

"{{{ airline
"---------------------------------- airline -----------------------------------

" Initialisation.
let g:airline_theme = 'onedark'
let g:airline_powerline_fonts = 1

" Dictionary must be defined before setting values. Also, it's a good idea to
" check whether it exists as to avoid accidentally overwriting its contents.
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif

" Status line settings.
let g:airline_detect_spell=1
let g:airline_stl_path_style = 'full'

" Status line symbols.
let g:airline_left_alt_sep = '|'
let g:airline_left_sep = ''
let g:airline_right_alt_sep = '|'
let g:airline_right_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = ' '
let g:airline_symbols.crypt = '🔒'
let g:airline_symbols.dirty='⚡'
let g:airline_symbols.linenr = ' '
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.notexists = 'Ɇ'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.readonly = ''
let g:airline_symbols.whitespace = ''

" Tab line.
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#left_sep = ''

"}}}

"{{{ colorizer.lua
"------------------------------- colorizer.lua --------------------------------

" Settings
lua require'colorizer'.setup()

" Mappings
nnoremap <leader>ct :ColorizerToggle<CR>
nnoremap <leader>cr :ColorizerReloadAllBuffers<CR>

"}}}

"{{{ color scheme
"------------------------------- color scheme ---------------------------------

" For onedark.vim: Removes the color scheme's background color and instead
" simply uses the terminal's background color.
if (has("autocmd"))
  augroup colorset
    autocmd!
    let s:white = {"gui": "#c5c5c5", "cterm": "145", "cterm16" : "7"}
    let s:background = {"gui": "#1a1b29", "cterm": "000", "cterm16" : "0"}
    autocmd ColorScheme * call onedark#set_highlight("Normal", {"fg": s:white})
    autocmd ColorScheme * call onedark#set_highlight("Normal", {"bg": s:background})
  augroup END
endif

" This stuff here needs to be stated before declaring the color scheme.
hi Comment cterm=italic
let g:onedark_hide_endofbuffer=1
let g:onedark_terminal_italics=1
let g:onedark_termcolors=256

" Declaring color scheme.
colorscheme onedark
set background=dark

"}}}

"{{{ telescope
"--------------------------------- telescope ----------------------------------

" Settings
lua <<EOF
-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
    defaults = {
        file_ignore_patterns = {
            "^.cache/",
            ".git/?"

        },
        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--column",
            "--line-number",
            "--no-heading",
            "--smart-case",
            "--with-filename",
            '--hidden'
        }
    },
    extensions = {
        fzf = {
            fuzzy = false,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case"
        }
    }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')
EOF

" Mappings
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files({hidden=true})<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fs <cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<cr>
nnoremap <leader>fv <cmd>lua require('telescope.builtin').treesitter()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap <leader>fc <cmd>lua require('telescope.builtin').commands()<cr>
nnoremap <leader>fm <cmd>lua require('telescope.builtin').man_pages()<cr>

"}}}

"{{{ treesitter
"-------------------------------- treesitter ----------------------------------

lua <<EOF
require'nvim-treesitter.configs'.setup {
    ensure_installed = "maintained",
    ignore_install = {"javascript"},
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        custom_captures = {
            ["foo.bar"] = "Identifier",
            },
        },
    }
EOF

"}}}

"{{{ undotree
"--------------------------------- undotree -----------------------------------

" Settings
let g:undotree_WindowLayout = 2
let g:undotree_ShortIndicators = 1
let g:undotree_SplitWidth = 24
let g:undotree_SetFocusWhenToggle = 1

" Mappings
nnoremap <leader>u :UndotreeToggle<CR>

"}}}

"}}}

"{{{ LSP
"------------------------------------------------------------------------------
"                                     LSP
"------------------------------------------------------------------------------

""""lua <<EOF
""""-- lua

""""require'lspconfig'.sumneko_lua.setup {}

""""-- bash
""""require'lspconfig'.bashls.setup{}

""""EOF


"}}}
