package Utils::Arrays::Simple;

use strict;
use warnings;
use Exporter 'import';

sub union {
  my ($arr1, $arr2) = @_;

  my @res;
  my %trackingHash;

  for my $element (@$arr1) {
    if (not $trackingHash{$element}) {
      $trackingHash{$element} = $element;
      push @res, $element;
    }
  }

  for my $element (@$arr2) {
    if (not $trackingHash{$element}) {
      $trackingHash{$element} = $element;
      push @res, $element;
    }
  }

  return @res;
}

1;

__END__

