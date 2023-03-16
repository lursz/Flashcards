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
    die
"Error: 3 arguments required.\nUsage: app.pl <file_name> <beginning_line> <ending_line>";
}
my $file_name = $ARGV[0];
my $beg_line  = $ARGV[1];
my $end_line  = $ARGV[2];

# ------------------------------ Read from XLSX ------------------------------ #
my $xlsx_reader = ReadXLSX->new( $file_name, $beg_line, $end_line );
$xlsx_reader->init();
$xlsx_reader->loadQuestions();
$xlsx_reader->loadAnswers();
$xlsx_reader->shuffle();

# -------------------------------- FlashCards -------------------------------- #
my $count  = 0;
my $length = $end_line - $beg_line;

ReadMode('cbreak');
while (1) {
    my $input = ReadKey(0);
    if ( $input eq " " ) {
        print $xlsx_reader->getAnswer($count), "\n";
    }
    elsif ( $input eq "a" ) {
        $count--;
        if ( $count < 0 ) {
            $count = 0;
        }
        $xlsx_reader->clearScreen();
        say "[$count/$length]   ", $xlsx_reader->getQuestion($count);
    }
    elsif ( $input eq "d" ) {
        $count++;
        if ( $count > $length ) {
            $count = $length;
        }
        $xlsx_reader->clearScreen();
        say "[$count/$length]   ", $xlsx_reader->getQuestion($count);

    }
}
ReadMode('normal');
