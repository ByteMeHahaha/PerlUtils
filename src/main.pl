#!/usr/bin/env perl

# Built-in and third-party modules
use lib 'lib';
use strict;
use warnings;

# My modules
use Utils::OS::LineCounter;

print "Lines: ", linecount("main.pl"), "\n";
