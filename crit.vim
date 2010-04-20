" Criticise a Perl file, and add colour markers to the margin indicating
" criticism severity.

if has('perl') 
" Define some useful commands and variables:
function! ShowCriticisms()
perl << END_PERL
VIM::DoCommand(':hi SignColumn guifg=fg guibg=bg');
VIM::DoCommand(':hi low_severity guifg=#004400 guibg=#004400 ctermfg=green');
VIM::DoCommand(':hi medium_severity guifg=#bbbb00 guibg=#bbbb00 ctermfg=cyan');
VIM::DoCommand(':hi high_severity guifg=#ff2222 guibg=#ff2222 ctermfg=red term=bold');
VIM::DoCommand(':sign define low_severity text=⑶ texthl=low_severity');
VIM::DoCommand(':sign define medium_severity text=② texthl=medium_severity');
VIM::DoCommand(':sign define high_severity text=① texthl=high_severity');

use lib "$ENV{'HOME'}/.vim/perl";

use Criticism qw( criticise );
# Tell the package we're in vim.
Criticism::in_vim;
criticise();

END_PERL
endfunction
    " Map the command critic to ShowCriticisms
    com! -nargs=0 Critic call ShowCriticisms()
    map <leader>cc <Esc>:Critic<Esc>

    "autocmd! BufReadPost,BufWritePost,FileReadPost,FileWritePost *.pl call ShowCriticisms()
    "autocmd! BufReadPost,BufWritePost,FileReadPost,FileWritePost *.pm call ShowCriticisms()
endif
