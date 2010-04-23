" Criticise a Perl file, and add colour markers to the margin indicating
" criticism severity.


let g:crit_low_sev_guifg='#004400'
let g:crit_low_sev_guibg='#004400'
let g:crit_low_sev_text='⑶ '
let g:crit_low_sev_ctermfg='green'
let g:crit_low_sev_ctermbg='black'

let g:crit_med_sev_guifg='#bbbb00'
let g:crit_med_sev_guibg='#bbbb00'
let g:crit_med_sev_text='② '
let g:crit_med_sev_ctermfg='cyan'
let g:crit_med_sev_ctermbg='black'

let g:crit_high_sev_guifg='#ff2222'
let g:crit_high_sev_guibg='#ff2222'
let g:crit_high_sev_text='① '
let g:crit_high_sev_ctermfg='black'
let g:crit_high_sev_ctermbg='red'

if has('perl') 
" Define some useful commands and variables:
function! ShowCriticisms()
perl << END_PERL
VIM::DoCommand(':hi SignColumn guifg=fg guibg=bg');
VIM::DoCommand(
  ':hi low_severity guifg=' . VIM::Eval('g:crit_low_sev_guifg') 
  . ' guibg=' . VIM::Eval('g:crit_low_sev_guifg') 
  . ' ctermfg=' . VIM::Eval('g:crit_low_sev_ctermfg')
  . ' ctermbg=' . VIM::Eval('g:crit_low_sev_ctermbg')
);
VIM::DoCommand(
  ':hi med_severity guifg=' . VIM::Eval('g:crit_med_sev_guifg') 
  . ' guibg=' . VIM::Eval('g:crit_med_sev_guifg') 
  . ' ctermfg=' . VIM::Eval('g:crit_med_sev_ctermfg')
  . ' ctermbg=' . VIM::Eval('g:crit_med_sev_ctermbg')
);
VIM::DoCommand(
  ':hi high_severity guifg=' . VIM::Eval('g:crit_high_sev_guifg') 
  . ' guibg=' . VIM::Eval('g:crit_high_sev_guifg') 
  . ' ctermfg=' . VIM::Eval('g:crit_high_sev_ctermfg')
  . ' ctermbg=' . VIM::Eval('g:crit_high_sev_ctermbg')
);
VIM::DoCommand(':sign define low_severity text=' . VIM::Eval('g:crit_low_sev_text') . ' texthl=low_severity');
VIM::DoCommand(':sign define medium_severity text=' . VIM::Eval('g:crit_med_sev_text') . ' texthl=medium_severity');
VIM::DoCommand(':sign define high_severity text=' . VIM::Eval('g:crit_high_sev_text') . ' texthl=high_severity');

use Vim::Criticism qw( criticise );
# Tell the package we're in vim.
Vim::Criticism::in_vim;
criticise();

END_PERL
endfunction
    " Map the command critic to ShowCriticisms
    com! -nargs=0 Critic call ShowCriticisms()
    map <leader>cc <Esc>:Critic<Esc>

    " Uncommend to run on read / write.
    "autocmd! BufReadPost,BufWritePost,FileReadPost,FileWritePost *.pl call ShowCriticisms()
    "autocmd! BufReadPost,BufWritePost,FileReadPost,FileWritePost *.pm call ShowCriticisms()
endif
