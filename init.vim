lua require("core.init")

"跳出括号
function! SkipPair() 
    if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'
        return "\<ESC>la"
    else
        return "\t"
    endif
endfunction
inoremap <TAB> <C-R>=SkipPair()<CR>

"多窗口编辑时, 临时放大某个窗口, 编辑完再切回原来的布局
function! ZoomToggle() abort
    if exists('t:zoomed') && t:zoomed
        execute t:zoom_winrestcmd
        let t:zoomed = 0
    else
        let t:zoom_winrestcmd = winrestcmd()
        resize
        vertical resize
        let t:zoomed = 1
    endif
endfunction
nnoremap <silent><Leader>z :call ZoomToggle()<CR>

" 书签图标
let g:bookmark_sign = ''


" F2 行号开关，用于鼠标复制代码用,为方便复制，用<F2>开启/关闭行号显示:
function! HideNumber() 
	if(&relativenumber == &number) 
		set relativenumber! number! 
	elseif(&number) 
		set number! 
	else 
		set relativenumber! 
	endif 
		set number? 
endfunc 
nnoremap <silent><F2> :call HideNumber()<CR>

" --------------- 自动折叠
set foldenable
set foldmethod=expr

set foldexpr=GetPotionFold(v:lnum)

function! NextNonBlankLine(lnum)
    let numlines = line('$')
    let current = a:lnum + 1

    while current <= numlines
        if getline(current) =~? '\v\S'
            return current
        endif

        let current += 1
    endwhile

    return -2
endfunction

function! IndentLevel(lnum)
    return indent(a:lnum) / &shiftwidth
endfunction

function! GetPotionFold(lnum)
    if getline(a:lnum) =~? '\v^\s*$'
        return '-1'
    endif

    let this_indent = IndentLevel(a:lnum)
    let next_indent = IndentLevel(NextNonBlankLine(a:lnum))

    if next_indent == this_indent
        return this_indent
    elseif next_indent < this_indent
        return this_indent
    elseif next_indent > this_indent
        return '>' . next_indent
    endif
endfunction
" 避免编辑器启动时代码自动折叠
set foldlevelstart=99 
" -------------------------------------

"背景透明
" highlight NormalNC guibg=NONE ctermbg=none
" highlight Comment guibg=NONE ctermbg=none
" highlight Constant guibg=NONE ctermbg=none
" highlight Special guibg=NONE ctermbg=none
" highlight Identifier guibg=NONE ctermbg=none
" highlight Statement guibg=NONE ctermbg=none
" highlight PreProc guibg=NONE ctermbg=none
" highlight Type guibg=NONE ctermbg=none
" highlight Underlined guibg=NONE ctermbg=none
" highlight Todo guibg=NONE ctermbg=none
" highlight String guibg=NONE ctermbg=none
" highlight Function guibg=NONE ctermbg=none
" highlight Conditional guibg=NONE ctermbg=none
" highlight Repeat guibg=NONE ctermbg=none
" highlight Operator guibg=NONE ctermbg=none
" highlight Structure guibg=NONE ctermbg=none
" highlight LineNr guibg=NONE ctermbg=none
" highlight NonText guibg=NONE ctermbg=none
" 左侧图标列背景
" highlight SignColumn guibg=NONE ctermbg=none
" highlight CursorLineNr guibg=NONE ctermbg=none
" highlight Normal guibg=NONE ctermbg=none
" highlight EndOfBuffer guibg=NONE ctermbg=none
" highlight BufferLineTabClose guibg=NONE ctermbg=none
" highlight BufferlineBufferSelected guibg=NONE ctermbg=none
" highlight BufferLineFill guibg=NONE ctermbg=none
" highlight BufferLineBackground guibg=NONE ctermbg=none
" highlight BufferLineSeparator guibg=NONE ctermbg=none
" highlight BufferLineIndicatorSelected guibg=NONE ctermbg=none
