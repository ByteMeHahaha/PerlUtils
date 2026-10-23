#!/usr/bin/env perl

use lib 'lib';
use strict;
use warnings;
use Test::More;

use Utils::TextFiles::LineCounter qw(linecount non_empty_linecount);
use Utils::TextFiles::LogFileParsing qw(count_logs_by_type);

subtest "LineCounter.pm" => sub {
  plan tests => 2;

  # Write a test file to test the function results against
  open my $fh, ">", "LineCounter.tmp" or die "Could not create LineCounter.tmp: $!\n";
  print $fh <<~EOF
  line 1
  line 2
  line 3
  line 4
  EOF
  ;
  close $fh;


  subtest "linecount()" => sub {
    plan tests => 3;

    # Test that the linecount subroutine correctly returns a count of 4
    is(
      linecount("LineCounter.tmp"),
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
      linecount("LineCounter.tmp"),
      0,
      "Doesn't return 0 for an existing file"
    );
  };

  unlink("LineCounter.tmp");
};

done_testing();
