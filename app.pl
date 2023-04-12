#!/usr/bin/perl
use strict;
use warnings;
use diagnostics;
use feature 'say';
use feature "switch";
use v5.34.0;
use Term::ReadKey;

use lib 'lib';
use ReadXLSXandCSV;

# ---------------------------- Read from terminal ---------------------------- #
if ( $#ARGV + 1 != 3 ) {
    die
"Error: 3 arguments required.\nUsage: app.pl <file_name> <beginning_line> <ending_line>";
}
my $file_name = $ARGV[0];
my $beg_line  = $ARGV[1];
my $end_line  = $ARGV[2];

# ------------------------------ Read from XLSX ------------------------------ #
my $reader = ReadXLSXandCSV->new(
    filename   => $file_name,
    begin_line => $beg_line,
    ending_line => $end_line
);
# -------------------------------- FlashCards -------------------------------- #
my $count  = 0;
my $length = $end_line - $beg_line;

ReadMode('cbreak');
while (1) {
    my $input = ReadKey(0);
    if ( $input eq " " ) {
        print $reader->getAnswer($count), "\n";
    }
    elsif ( $input eq "a" ) {
        $count--;
        if ( $count < 0 ) {
            $count = 0;
        }
        $reader->clearScreen();
        say "[$count/$length]   ", $reader->getQuestion($count);
    }
    elsif ( $input eq "d" ) {
        $count++;
        if ( $count > $length ) {
            $count = $length;
        }
        $reader->clearScreen();
        say "[$count/$length]   ", $reader->getQuestion($count);

    }
}
ReadMode('normal');
