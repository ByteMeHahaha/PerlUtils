#!/usr/bin/env perl

use lib 'lib';
use strict;
use warnings;
use Test::More;

use Utils::TextFiles::LogFileParsing qw(count_logs_by_type);

# Write a test file to test the function results against
open my $fh, ">", "testing.tmp" or die "Could not create testing.tmp: $!\n";
print $fh <<EOF
[LOG]
[ERR]
[LOG]
[LOG]
[LOG]
[WARN]
[ERR]
[WARN]
[INFO]
[LOG]
[INFO]
EOF
;
close $fh;

# ====================================
# Log type counting
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

# ====================================
# End of testing

unlink("testing.tmp");
done_testing();
