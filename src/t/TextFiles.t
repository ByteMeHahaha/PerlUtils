#!/usr/bin/env perl

use lib 'lib';
use strict;
use warnings;
use Test::More;
use Utils::TextFiles::Simple qw(
  can_open
  cant_open
);
use Utils::TextFiles::LineCounter qw(
  linecount
  non_empty_linecount
);
use Utils::TextFiles::LogFileParsing qw(
  count_logs_by_type
  filter_logs
);

# Tests for Simple.pm
subtest "Simple" => sub {
  subtest "can_open()" => sub {
    open my $fh, '>', "Test.tmp"
      or die "Could not create Test.tmp: $!";
    print $fh "I can be opened!\n";
    close $fh;

    is(
      can_open("Test.tmp"),
      1,
      "File can be opened and sub returns 0"
    );

    isnt(
      can_open("Doesnt-Exist.tmp"),
      1,
      "Non-existent file returns 0"
    );

    unlink "Test.tmp";
  };

  subtest "cant_open()" => sub {
    open my $fh, '>', "Exists.tmp"
      or die "Could not open Exists.tmp: $!";
    close $fh;

    is(
      cant_open("Exists.tmp"),
      0,
      "File does open, and sub returns 0"
    );

    is(
      cant_open("Non-Existent-File.tmp"),
      1,
      "File cannot open, and sub returns 1"
    );

    unlink "Exists.tmp";
  };
};

# Tests for LineCounter.pm
subtest "LineCounter" => sub {
  subtest "linecount()" => sub {
    # Write a test file to test the function results against
    open my $fh, ">", "LineCounter.tmp" or die "Could not create LineCounter.tmp: $!";
    print $fh <<~EOF
    line 1
    line 2
    line 3
    line 4
    EOF
    ;
    close $fh;

    # Write an empty test file
    open $fh, '>', "empty.txt" or die "Could not create empty.txt: $!";
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

    # Test that the linecount returns 0 for an empty file
    is(
      linecount("empty.txt"),
      0,
      "Returns 0 for an empty, existing file"
    );
  };

  subtest "non_empty_linecount()" => sub {
    # Write a test file to test the function results against
    open my $fh, ">", "LineCounter.tmp" or die "Could not create LineCounter.tmp: $!";
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

    # Delete the testing files
    unlink "LineCounter.tmp";
    unlink "empty.txt";
  };
};

# Tests for LogFileParsing.pm
subtest "LogFileParsing" => sub {
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

  subtest "filter_logs()" => sub {
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
      scalar filter_logs('ERR', 'testing.tmp'),
      2,
      "Filters 2 Error logs"
    );

    is(
      scalar filter_logs('[ERR]', 'testing.tmp'),
      2,
      "Filters 2 Error logs with square brackets in the supplied log type"
    );

    unlink("testing.tmp");
  };
};

# Check that the number of executed tests is correct
done_testing(3);
