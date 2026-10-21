#!/usr/bin/env perl

use lib 'lib';
use strict;
use warnings;
use Test::More;

use Utils::OS::LineCounter qw(linecount);

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

# Test that the linecount subroutine correctly returns 4
is(
  linecount("testing.tmp"),
  4,
  "Line count should be 4"
);

is(
  linecount("nonexistent.txt"),
  0,
  "Returns 0 when the file doesn't exist"
);

# Delete the testing file
unlink "testing.tmp";

# Conclude tests for this module
done_testing();
