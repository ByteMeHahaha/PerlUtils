#!/usr/bin/env perl

use lib 'lib';
use strict;
use warnings;
use Test::More;

use Utils::TextFiles::LineCounter qw(non_empty_linecount);

# Write a test file to test the function results against
open my $fh, ">", "testing.tmp" or die "Could not create testing.tmp: $!\n";
print $fh <<EOF
line 1
line 2
line 3
line 4

Line 5
Line 6

Line 7
EOF
;
close $fh;

is(
  non_empty_linecount("testing.tmp"),
  7,
  "Counts non-empty lines"
);

isnt(
  non_empty_linecount("testing.tmp"),
  9,
  "Doesn't count empty lines"
);

# Delete the testing file
unlink "testing.tmp";

# Conclude tests for this module
done_testing();
