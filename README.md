Vim-Perl-Critic
---------------

A perl critic plugin for vim which creates marks and an awesome quickfix of
your not-so-quick to fix errors.

Usage:
======

Type `<leader>cc` (typically `\cc`), to fire up the quickfix list of your perl foibles.

To clear the signs from the margin, use:

        :sign unplace *

You can also set:

        autocmd! BufReadPost,BufWritePost,FileReadPost,FileWritePost *.pl call ShowCriticisms()
        autocmd! BufReadPost,BufWritePost,FileReadPost,FileWritePost *.pm call ShowCriticisms()

To have it run whenever you save or load a perl buffer.

Configuration:
==============

The text, colours and criticism severity are configurable. To change them, just
set the following variables.

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

        let g:crit_severity_level=3

Be warned, there is no sanity checking of these, and empty text variables don't
work.

TODO:
=====

See: http://github.com/mattfoster/vim-Perl-Critic/issues
