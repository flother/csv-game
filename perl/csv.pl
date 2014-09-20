#!/usr/bin/perl
use strict;
use Text::CSV_XS 1.000;

my @rows;
my $csv = Text::CSV_XS->new ( { binary => 1 } )
    or die "Cannot use CSV: ".Text::CSV_XS->error_diag ();

open my $fh, "<:encoding(latin1)", "/dev/stdin" or die "stdin: $!";
my $sum = 0;
while ( my $row = $csv->getline( $fh ) ) {
    $sum += scalar @{ $row }
}
$csv->eof or $csv->error_diag();
close $fh;
print $sum
