command! -nargs=0 SC call <SID>ExchangeTemplateYaon()

function! s:ExchangeTemplateYaon()
  let target = s:GetTargetName()
  if strlen(target) <= 0 || target ==# expand('%')
    echomsg 'Cannot get correspond file: ' . expand('%')
    return 0
  endif

  echo target

  if filereadable(target)
    execute ':e' .target
  else
    echo 'Cannot read correspond file.'
  endif
endfunction " s:UtestAppend()

function! s:GetTargetName()
  let curr = expand('%:p')
  if expand('%:e') ==# 'yaon'
    let htmlfile = substitute(curr, '^\(..*\)/config\(\(/[^/][^/]*\)*\)/models-\(..*\)\.yaon$', '\1/template\2/\4.html', 'i')
    return htmlfile
  elseif expand('%:e') ==# 'html'
    let yaonfile = substitute(curr, '^\(..*\)/template\(\(/[^/][^/]*\)*\)/\(..*\)\.html$', '\1/config\2/models-\4.yaon', 'i')
    return yaonfile
  else
    return ''
  endif
endfunction " s:GetTargetName()
