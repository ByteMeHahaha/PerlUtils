package Utils::OS::LineCounter;

use strict;
use warnings;
use Exporter 'import';

our @EXPORT_OK = qw(linecount);
our @EXPORT = qw(linecount);

sub linecount {
  my ($filename) = @_;

  open my $fh, '<', "$filename"
    or die "Cannot open file $filename: $!\n";

  if (-z $fh) {
    return 0;
  }

  my $lc = 0;

  while (my $line = <$fh>) {
    $lc++;
  }

  return $lc;
}

1;
