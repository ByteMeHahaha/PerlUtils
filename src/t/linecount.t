#!/usr/bin/env perl

use lib 'lib';
use strict;
use warnings;
use Test::More;

use Utils::TextFiles::LineCounter qw(linecount);

# Write a test file to test the function results against
open my $fh, ">", "testing.tmp" or die "Could not create testing.tmp: $!\n";
print $fh <<EOF
line 1
line 2
line 3
line 4
EOF
;
close $fh;

# Test that the linecount subroutine correctly returns a count of 4
is(
  linecount("testing.tmp"),
  4,
  "Correctly counts four lines"
);

# Test that the linecount subroutine returns a count of 0 for a non-existent file
is(
  linecount("nonexistent.txt"),
  0,
  "Returns 0 when the file doesn't exist"
);

# Test that the linecount subroutine doesn't return 0 for an existing file
isnt(
  linecount("testing.tmp"),
  0,
  "Doesn't return 0 for an existing file"
);

# Delete the testing file
unlink "testing.tmp";

# Conclude tests for this module
done_testing();
