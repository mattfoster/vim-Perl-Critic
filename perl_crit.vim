" Criticise a Perl file, and add colour markers to the margin indicating
" criticism severity.

if !exists('g:crit_low_sev_guifg')
    let g:crit_low_sev_guifg='#004400'
endif

if !exists('g:crit_low_sev_guibg')
    let g:crit_low_sev_guibg='#004400'
endif

if !exists('g:crit_low_sev_text')
    let g:crit_low_sev_text='⑶ '
endif

if !exists('g:crit_low_sev_ctermfg')
    let g:crit_low_sev_ctermfg='green'
endif

if !exists('g:crit_low_sev_ctermbg')
    let g:crit_low_sev_ctermbg='black'
endif

if !exists('g:crit_med_sev_guifg')
    let g:crit_med_sev_guifg='#bbbb00'
endif

if !exists('g:crit_med_sev_guibg')
    let g:crit_med_sev_guibg='#bbbb00'
endif

if !exists('g:crit_med_sev_text')
    let g:crit_med_sev_text='② '
endif

if !exists('g:crit_med_sev_ctermfg')
    let g:crit_med_sev_ctermfg='cyan'
endif

if !exists('g:crit_med_sev_ctermbg')
    let g:crit_med_sev_ctermbg='black'
endif

if !exists('g:crit_high_sev_guifg')
    let g:crit_high_sev_guifg='#ff2222'
endif

if !exists('g:crit_high_sev_guibg')
    let g:crit_high_sev_guibg='#ff2222'
endif

if !exists('g:crit_high_sev_text')
    let g:crit_high_sev_text='① '
endif

if !exists('g:crit_high_sev_ctermfg')
    let g:crit_high_sev_ctermfg='black'
endif

if !exists('g:crit_high_sev_ctermbg')
    let g:crit_high_sev_ctermbg='red'
endif

if !exists('g:crit_severity_level')
    let g:crit_severity_level=3
endif

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
VIM::DoCommand(':sign define med_severity text=' . VIM::Eval('g:crit_med_sev_text') . ' texthl=med_severity');
VIM::DoCommand(':sign define high_severity text=' . VIM::Eval('g:crit_high_sev_text') . ' texthl=high_severity');

use Vim::Perl::Critic qw( criticise );
# Tell the package we're in vim.
Vim::Perl::Critic::in_vim;
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
