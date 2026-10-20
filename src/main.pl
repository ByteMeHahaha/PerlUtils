#!/usr/bin/env perl

# Built-in and third-party modules
use lib 'lib';
use strict;
use warnings;

# My modules
use Utils::OS::LineCounter qw(linecount);

print "Lines: ", linecount("main.pl"), "\n";
