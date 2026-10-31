package Utils::Arrays::Simple;

use strict;
use warnings;
use Exporter 'import';

sub union {
  # Parameters
  my ($arr1, $arr2) = @_;

  # Result array
  my @union;
  # Hash for tracking elements
  my %trackingHash;

  # Loop through the first array
  for my $element (@$arr1) {
    # If the element was not previously encountered
    if (not $trackingHash{$element}) {
      # Add that element to the tracking hash
      $trackingHash{$element} = $element;
      # Push the element to the result array
      push @union, $element;
    }
  }

  # Loop through the second array
  for my $element (@$arr2) {
    # If the element was not previously encountered
    if (not $trackingHash{$element}) {
      # Add that element to the tracking hash
      $trackingHash{$element} = $element;
      # Push the element to the result array
      push @union, $element;
    }
  }

  # Return the result array
  return @union;
}

1;

__END__
