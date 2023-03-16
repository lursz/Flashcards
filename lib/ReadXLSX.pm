package ReadXLSX;
use strict;
use warnings;
no warnings 'utf8';
use diagnostics;
use feature 'say';
use feature "switch";

use Spreadsheet::Read qw(ReadData);

# ---------------------------------------------------------------------------- #
#                                Class ReadXLSX                                #
# ---------------------------------------------------------------------------- #
my $book_data;
my @answers;
my @questions;

sub new {
    my $class = shift;
    my ( $filename, $begin_line, $ending_line ) = @_;
    my $self = {
        filename    => $filename,
        begin_line  => $begin_line,
        ending_line => $ending_line,
    };
    bless $self, $class;
    return $self;
}

sub init {
    my $self = shift;
    $book_data = ReadData( $self->{filename} );
    say "Good luck bro";
}

sub loadQuestions {
    my $self = shift;
    for my $i ( $self->{begin_line} .. $self->{ending_line} ) {
        my @row = Spreadsheet::Read::row( $book_data->[1], $i );
        push @questions, $row[0];
    }
}

sub loadAnswers {
    my $self = shift;
    for my $i ( $self->{begin_line} .. $self->{ending_line} ) {
        my @row = Spreadsheet::Read::row( $book_data->[1], $i );
        push @answers, $row[1];
    }
}

sub shuffle {
    my $self = shift;
    my $length = scalar @questions; # scalar = length of array
    my @indices = ( 0 .. ( $length - 1 ) );

    for ( my $i = $length - 1 ; $i > 0 ; $i-- ) {
        my $j = int( rand( $i + 1 ) );
        ( $indices[$i], $indices[$j] ) = ( $indices[$j], $indices[$i] );
    }

    # Shuffle the arrays
    for ( my $i = 0 ; $i < $length ; $i++ ) {
        my $shuffled_index = $indices[$i];
        ( $questions[$i], $questions[$shuffled_index] ) =
          ( $questions[$shuffled_index], $questions[$i] );
        ( $answers[$i], $answers[$shuffled_index] ) =
          ( $answers[$shuffled_index], $answers[$i] );
    }

}

sub clearScreen {
    my ($self) = @_;
    print "\033[2J";
    print "\033[0;0H";
}

# --------------------------------- get & set -------------------------------- #
sub getAnswer {
    my $self = shift;
    my ($index) = @_;
    return $answers[$index];
}

sub getQuestion {
    my $self = shift;
    my ($index) = @_;
    return $questions[$index];
}

sub getAllAnswers {
    my $self = shift;
    for my $i ( $self->{begin_line} .. $self->{ending_line} ) {
        my @row = Spreadsheet::Read::row( $book_data->[1], $i );
        push @answers, $row[1];
    }
    return @answers;
}

sub getAllQuestions {
    my $self = shift;
    for my $i ( $self->{begin_line} .. $self->{ending_line} ) {
        my @row = Spreadsheet::Read::row( $book_data->[1], $i );
        push @questions, $row[0];
    }
    return @questions;
}
1;
