if !exists("g:rustfmt_on_save")
    let g:rustfmt_on_save = 1
endif

if !exists("g:rustfmt_backup")
    let g:rustfmt_backup  = 0
endif


function! rustfmt#RustfmtEnable()
    let g:rustfmt_on_save = 1
endfunction
function! rustfmt#RustfmtDisable()
    let g:rustfmt_on_save = 0
endfunction
function! rustfmt#RustfmtToggle()
    let g:rustfmt_on_save = !g:rustfmt_on_save
endfunction


function! rustfmt#Rustfmt() range
    if !executable("rustfmt")
        echomsg "Rustfmt not found in $PATH, did you install it?
                    \ (rustup component add rustfmt)"
        return
    endif

    " Write the buffer to rustfmt, rather than having it use the
    " file on disk, because that file might not have been created yet!
    silent! w !rustfmt > /dev/null 2>&1

    if v:shell_error
        echohl WarningMsg
        echo "Rustfmt: Parsing error\n"
        echohl None
    else
        let l:edition_opt = " --edition 2018"
        if exists("g:rustfmt_edition")
          let l:edition_opt = " --edition " . g:rustfmt_edition
        endif

        let l:backup_opt = ""
        if g:rustfmt_backup == 1
            let l:backup_opt = " --backup"
        endif

        silent! exe "undojoin"
        silent! exe "keepjumps " . a:firstline . "," . a:lastline . "!rustfmt" . l:edition_opt . l:backup_opt
    endif

    call winrestview(b:winview)
endfunction

function! rustfmt#RustfmtOnSave()
    if g:rustfmt_on_save == 1
        let b:winview = winsaveview()
        exe "%call rustfmt#Rustfmt()"
    endif
endfunction


augroup rustfmt
    autocmd!
    autocmd BufWritePre *.rs call rustfmt#RustfmtOnSave()
augroup END


command! -range=% Rustfmt exe "let b:winview = winsaveview() | <line1>, <line2>call rustfmt#Rustfmt()"
command! RustfmtEnable exe "call rustfmt#RustfmtEnable()"
command! RustfmtDisable exe "call rustfmt#RustfmtDisable()"
command! RustfmtToggle exe "call rustfmt#RustfmtToggle()"
