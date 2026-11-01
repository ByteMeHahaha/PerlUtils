#!/usr/bin/env perl

use strict;
use warnings;
use Test::More;

use Utils::Arrays::Sets qw(
  union
);

subtest "Arrays::Sets" => sub {
  subtest "union()" => sub {
    my @arr1 = (1, 2, 3, 4);
    my @arr2 = (3, 4, 5, 6);

    my @res = union(\@arr1, \@arr2);

    is_deeply(\@res, [1, 2, 3, 4, 5, 6], "Correctly determines the union");
  };

  done_testing();
};


done_testing();
