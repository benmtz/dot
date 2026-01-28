function! floaterm#wrapper#prs#(cmd, jobopts, config) abort
  let s:prs_tmpfile = tempname()
  let cmd = a:cmd . '--print-file  > ' . s:prs_tmpfile
  let a:jobopts.on_exit = funcref('s:prs_callback')
  return [v:false, cmd]
endfunction

function! s:prs_callback(...) abort
  if filereadable(s:prs_tmpfile)
    let filenames = readfile(s:prs_tmpfile)
    if !empty(filenames)
      if has('nvim')
        call floaterm#window#hide(bufnr('%'))
      endif
      let locations = []
      for filename in filenames
        let dict = {'filename': fnamemodify(filename, ':p')}
        call add(locations, dict)
      endfor
      call floaterm#util#open(locations)
    endif
  endif
endfunction
