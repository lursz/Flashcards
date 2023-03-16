#!/usr/bin/perl
use strict;
use warnings;
use diagnostics;
use feature 'say';
use feature "switch";
use v5.34.0;
use Term::ReadKey;

use lib 'lib';
use ReadXLSX;



# ---------------------------- Read from terminal ---------------------------- #
if ( $#ARGV + 1 != 3 ) {
    die "Error: 3 arguments required.\nUsage: app.pl <file_name> <beginning_line> <ending_line>";
}
my $file_name = $ARGV[0];
my $beg_line  = $ARGV[1];
my $end_line  = $ARGV[2];

# ------------------------------ Read from XLSX ------------------------------ #
my $xlsx_reder = ReadXLSX->new($file_name, $beg_line, $end_line);

$xlsx_reder->loadQuestions();
$xlsx_reder->loadAnswers();
$xlsx_reder->shuffle();



# -------------------------------- FlashCards -------------------------------- #
my $count = 0;
my $length = $end_line - $beg_line;
ReadMode('cbreak');
while (1) {
    say "[$count/$length]   ", $xlsx_reder->getQuestion($count);
    my $input = ReadKey(0);
    if ( $input eq " " ) {
        print "\t\t\t\t\t\t\t---------------\n\t\t\t\t";
        print $xlsx_reder->getAnswer($count), "\n";
        $count++;
    }
    elsif ( $input eq "a" ) {    # Up or right arrow key
        $count--;
    }
    elsif ( $input eq "d" ) {    # Down or left arrow key
        $count++;
    }
}
ReadMode('normal');
