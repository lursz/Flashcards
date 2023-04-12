package ReadXLSXandCSV;
use Moose;
use strict;
use warnings;
no warnings 'utf8';
use diagnostics;
use feature 'say';
use feature "switch";

use Text::CSV;
use List::Util 'shuffle';
use Spreadsheet::Read qw(ReadData);

# ---------------------------------------------------------------------------- #
#                             Class ReadXLSXandCSV                             #
# ---------------------------------------------------------------------------- #
has 'book_data' => (is => 'rw', isa => 'ArrayRef', default => sub { [] } );
has 'filename' => (is => 'ro', isa => 'Str', required => 1);
has 'begin_line' => (is => 'ro', isa => 'Int', required => 1);
has 'ending_line' => (is => 'ro', isa => 'Int', required => 1);
has 'array' => ( is => 'rw', isa => 'ArrayRef', default => sub { [] } );

sub BUILD {
    my $self = shift;
    $self->init();
 

}

sub init {
    my $self = shift;
    say "Reading file...";
    if ($self->{filename} =~ m/\.xlsx$/) {
        $self->readXLSX();
    }
    elsif ($self->{filename} =~ m/\.csv$/) {
        $self->readCSV();
    }
    else {
        die "Error: File format not supported";
    }
    $self->shuffleArray();
    say "Done. Use [a][space][d] to navigate";
}




sub readXLSX {
    my $self = shift;
    $self->{book_data} = ReadData( $self->{filename} );
    for my $i ( $self->{begin_line} .. $self->{ending_line} ) {
        my @row = Spreadsheet::Read::row( $self->{book_data}[1], $i );
        push @{ $self->{array} }, [$row[0], $row[1]];
    }
}

sub readCSV {
    my $self = shift;
    my $csv = Text::CSV->new({binary => 1, auto_diag => 1});
    open(my $fh, "<", $self->{filename}) or die "Cannot open the file";

    for my $i ( $self->{begin_line} .. $self->{ending_line} ) {
        my $row = $csv->getline($fh);
        push @{ $self->{array} }, [$row->[0], $row->[1]];
    }
}

sub shuffleArray {
    my $self = shift;
    @{ $self->{array} } = shuffle @{ $self->{array} };
}


sub clearScreen {
    my ($self) = @_;
    print "\033[2J";
    print "\033[0;0H";
}

# ------------------------------------ get ----------------------------------- #
sub getAnswer {
    my $self = shift;
    my ($index) = @_;
    return $self->{array}[$index][1];
}

sub getQuestion {
    my $self = shift;
    my ($index) = @_;
    return $self->{array}[$index][0];
}

sub getAllAnswers {
    my $self = shift;
    my @answers;
    my $length = scalar @{ $self->{array} };
    for my $i ( 0 .. $length ) {
        push @answers, $self->{array}[$i][1];
    }
    return @answers;
}

sub getAllQuestions {
    my $self = shift;
    my @questions;
    my $length = scalar @{ $self->{array} };
    for my $i ( 0 .. $length ) {
        push @questions, $self->{array}[$i][0];
    }
    return @questions;
}
1;
