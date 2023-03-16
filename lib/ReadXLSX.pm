package ReadXLSX;
use strict;
use warnings;
use diagnostics;
use feature 'say';
use feature "switch";

use Spreadsheet::Read qw(ReadData);

# ---------------------------------------------------------------------------- #
#                                Class ReadXLSX                                #
# ---------------------------------------------------------------------------- #
# my $book_data = ReadData('lib/ex.xlsx');
my $book_data;
my @answers;
my @questions;


sub new {
    my $class = shift;
    my ( $filename, $begin_line, $ending_line ) = @_;
    my $self = {
        filename => $filename,
        begin_line => $begin_line,
        ending_line => $ending_line,
    };
    bless $self, $class;
    return $self;
}

sub init{
    my $self = shift;
    $book_data = ReadData($self->{filename});
}
sub loadQuestions{
    my $self = shift;
    for my $i ( $self->{begin_line} .. $self->{ending_line} ) {
        my @row = Spreadsheet::Read::row( $book_data->[1], $i );
        push @questions, $row[0];
    }
}

sub loadAnswers{
    my $self = shift;
    for my $i ( $self->{begin_line} .. $self->{ending_line} ) {
        my @row = Spreadsheet::Read::row( $book_data->[1], $i );
        push @answers, $row[1];
    }
}


# shuffle questions and answers
sub shuffle{
    my $self = shift;
    my $size = $self->{ending_line} - $self->{begin_line};
    my @shuffled_questions;
    my @shuffled_answers;
    my @indexes;
    for my $i (0 .. $size){
        push @indexes, $i;
    }
    for my $i (0 .. $size){
        my $index = int(rand($size));
        push @shuffled_questions, $questions[$indexes[$index]];
        push @shuffled_answers, $answers[$indexes[$index]];
        splice @indexes, $index, 1; # remove the element at $index from @indexes with length 1
    }
    @questions = @shuffled_questions;
    @answers = @shuffled_answers;
}



sub getAnswer{
    my $self = shift;
    my ($index) = @_;
    return $answers[$index];
}

sub getQuestion{
    my $self = shift;
    my ($index) = @_;
    return $questions[$index];
}


sub getAnswers{
    my $self = shift;
    for my $i ( $self->{begin_line} .. $self->{ending_line} ) {
        my @row = Spreadsheet::Read::row( $book_data->[1], $i );
        push @answers, $row[1];
    }
    return @answers;
}


sub getAuestions{
    my $self = shift;
    for my $i ( $self->{begin_line} .. $self->{ending_line} ) {
        my @row = Spreadsheet::Read::row( $book_data->[1], $i );
        push @questions, $row[0];
    }
    return @questions;
}

sub clearScreen {
    my ($self) = @_;
    print "\033[2J";
    print "\033[0;0H";
}


1;
