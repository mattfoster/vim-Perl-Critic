# Criticism - Criticise a file in VIM, and prettify the output.
package Vim::Perl::Critic;

use warnings;
use strict;
use base qw( Exporter );
our @EXPORT_OK = qw( criticise );

use Carp;
use Perl::Critic qw( critique );
Perl::Critic::Violation::set_format("%f:%l:%c:%s:%m");
use Readonly;

my $in_vim = 0;

sub in_vim {
    return $in_vim = 1;
}

# Split on colons, return a given element.
sub get_element {
    my $input = shift;
    my $index = shift;
    my @split_line = split /:/x, $input;
    return $split_line[$index]; 
}

Readonly my %severities => (
    1 => 'low_severity',
    2 => 'low_severity',
    3 => 'med_severity',
    4 => 'high_severity',
    5 => 'high_severity'
);

sub criticise {
    # If we're given a file handle, use it for debugging:
    my $file;
    # Bundle vim commands together.
    if ($in_vim) {
        $file = VIM::Eval('expand("%:p")');
        VIM::DoCommand(":setlocal errorformat='%f:%l:%c:%m'");
        VIM::DoCommand(':sign unplace *');
    }
    else {
       croak 'Not running in vim. No $file set'; 
    }

    my ($s, $level) = VIM::Eval('g:crit_severity_level');

    # Run perlcritic
    my @unsorted_violations = critique({ -severity => $level}, $file);

    if ( ! @unsorted_violations) {
        VIM::DoCommand(q{:echohl WarningMsg | echo "Nothing to report." | echohl None});
        return;
    }

    # Schwartzian goodness: sort by line, and severity.
    my @violations = 
        map {$_->[0]} 
        sort { $a->[1] <=> $b->[1] or $a->[2] <=> $b->[2] }
        map  {[ $_, get_element($_, 1), get_element($_, 3) ]} 
        @unsorted_violations; 

    my @quoted_vs = map {
        $_ =~ s{"}{}g;
        $_ =~ s{\|}{\\|}g;
        $_
    } @violations;

    my $joined = join( '\n', @quoted_vs );
    my $quoted = '"' . $joined . '\n"'; 
    
    # Set up the quickfix list of errors
    if ($in_vim) {
        VIM::DoCommand(':lexpr '.$quoted);
        VIM::DoCommand(qq(:lope));
    }

    # TODO: only bother reporting the highest severity on each line.
    foreach my $violation (@violations){ 
        my (undef, $line, $col, $sev, $message) = 
            split /:/x, $violation;
        my $name = $severities{$sev};
        my $cmd = ":sign place $line line=$line name=$name file=$file";
        #print {$fh} $cmd, "\n"; 
        if ($in_vim) {        
            VIM::DoCommand($cmd);
        }
    }

    return;
}

1;
