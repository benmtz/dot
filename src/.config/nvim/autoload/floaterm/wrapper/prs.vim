function! floaterm#wrapper#prs#(cmd, jobopts, config) abort
  let s:prs_tmpfile = tempname()
  let original_dir = getcwd()
  lcd %:p:h

  let cmdlist = split(a:cmd)
  let cmd = 'prs --print-file "' . s:prs_tmpfile . '"'

  exe "lcd " . original_dir
  let cmd = [&shell, &shellcmdflag, cmd]
  let jobopts = {'on_exit': funcref('s:prs_callback')}
  call floaterm#util#deep_extend(a:jobopts, jobopts)
  return [v:false, cmd]
endfunction

function! s:prs_callback(job, data, event, opener) abort
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
      call floaterm#util#open(locations, a:opener)
    endif
  endif
endfunction

