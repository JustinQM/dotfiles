" wrapper: force -raw + stderr→stdout
function! s:AsyncRunRaw(cmd, bang) abort
  let l:full = '-raw ' . a:cmd . ' 2>&1'
  call asyncrun#run(split(l:full, '\s\+'), a:bang ? {'bang': 1} : {})
endfunction

" Override :AsyncRun and :AsyncRun!
command! -bang -nargs=+ AsyncRun
  \ call s:AsyncRunRaw(<q-args>, <bang>0)
