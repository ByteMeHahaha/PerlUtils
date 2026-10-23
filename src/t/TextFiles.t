#!/usr/bin/env perl

use lib 'lib';
use strict;
use warnings;
use Test::More;

use Utils::TextFiles::LineCounter qw(linecount non_empty_linecount);
use Utils::TextFiles::LogFileParsing qw(count_logs_by_type);

subtest "LineCounter.pm" => sub {
  subtest "linecount()" => sub {
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

  subtest "non_empty_linecount()" => sub {
    # Write a test file to test the function results against
    open my $fh, ">", "LineCounter.tmp" or die "Could not create LineCounter.tmp: $!\n";
    print $fh <<~EOF
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
      non_empty_linecount("LineCounter.tmp"),
      7,
      "Counts non-empty lines"
    );

    isnt(
      non_empty_linecount("LineCounter.tmp"),
      9,
      "Doesn't count empty lines"
    );

    # Delete the testing file
    unlink "LineCounter.tmp";
  };
};

subtest "LogFileParsing.pm" => sub {
  subtest "count_logs_by_type()" => sub {
    # Write a test file to test the function results against
    open my $fh, ">", "testing.tmp" or die "Could not create testing.tmp: $!\n";
    print $fh <<~EOF
    [ERR]
    [ERR]
    [INFO]
    [INFO]
    [LOG]
    [LOG]
    [LOG]
    [LOG]
    [LOG]
    [WARN]
    [WARN]
    EOF
    ;
    close $fh;

    is(
      count_logs_by_type("INFO", "testing.tmp"),
      2,
      "There are two info logs counted"
    );

    is(
      count_logs_by_type("LOG", "testing.tmp"),
      5,
      "There are five normal logs counted"
    );

    unlink("testing.tmp");
  };
};

done_testing();
