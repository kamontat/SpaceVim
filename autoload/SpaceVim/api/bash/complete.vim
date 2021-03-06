let s:self = {}

let s:completer = fnamemodify(g:Config_Main_Home, ':p:h:h') . '/autoload/SpaceVim/bin/get_complete'

let s:COP = SpaceVim#api#import('vim#compatible')

" this is for vim command completion 

function! s:self.complete(ArgLead, CmdLine, CursorPos) abort
  if a:CmdLine =~ '^[^ ]*$'
    return s:COP.systemlist('compgen -c ' . a:CmdLine)
  endif
  let result = s:COP.systemlist([s:completer, a:CmdLine])
  return map(result, 'substitute(v:val, "[ ]*$", "", "g")')
endfunction


" this is for vim input()

function! s:self.complete_input(ArgLead, CmdLine, CursorPos) abort
  if a:CmdLine =~ '^[^ ]*$'
    return s:COP.systemlist('compgen -c ' . a:CmdLine)
  endif
  let result = s:COP.systemlist([s:completer, a:CmdLine])
  if a:ArgLead == ''
    let result = map(result, 'a:CmdLine . v:val')
  else
    let leader = substitute(a:CmdLine, '[^ ]*$', '', 'g')
    let result = map(result, 'leader . v:val')
  endif
  return result

endfunction


function! SpaceVim#api#bash#complete#get()

  return deepcopy(s:self)

endfunction
