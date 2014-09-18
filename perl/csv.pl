#!/usr/bin/perl
use strict;
use Text::CSV 1.000;

my @rows;
my $csv = Text::CSV->new ( { binary => 1 } )  # should set binary attribute.
    or die "Cannot use CSV: ".Text::CSV->error_diag ();

open my $fh, "<:encoding(latin1)", "/dev/stdin" or die "stdin: $!";
my $sum = 0;
while ( my $row = $csv->getline( $fh ) ) {
    $sum += scalar @{ $row }
}
$csv->eof or $csv->error_diag();
close $fh;
print $sum
