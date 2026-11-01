#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

use Utils::Arrays::Simple qw(
  union
);

subtest "Arrays::Simple" => sub {
  subtest "union()" => sub {
    my @arr1 = (1, 2, 3, 4);
    my @arr2 = (3, 4, 5, 6);

    my @res = union(\@arr1, \@arr2);

    is_deeply(\@res, [1, 2, 3, 4, 5, 6], "Correctly determines the union");
  };

  done_testing();
};


done_testing();
