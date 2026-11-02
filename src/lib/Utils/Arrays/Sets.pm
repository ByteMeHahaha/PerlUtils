package Utils::Arrays::Sets;

use strict;
use warnings;
use Exporter 'import';

our @EXPORT_OK = qw(
  union
);

sub union {
  # Parameters
  my ($arr1, $arr2) = @_;

  # Result array
  my @union;
  # Hash for tracking elements
  my %trackingHash;

  # Loop through the first array
  foreach my $element (@$arr1) {
    # If the element was not previously encountered
    if (not exists $trackingHash{$element}) {
      # Add a truthy value for that element to the tracking hash
      $trackingHash{$element} = 1;

      # Push the element to the result array
      push @union, $element;
    }
  }

  # Loop through the second array
  foreach my $element (@$arr2) {
    # If the element was not previously encountered
    if (not exists $trackingHash{$element}) {
      # Add a truthy value for that element to the tracking hash
      $trackingHash{$element} = 1;

      # Push the element to the result array
      push @union, $element;
    }
  }

  # Return the result array
  return @union;
}

1;

__END__

=pod

=head1 NAME

C<Arrays::Sets> - Mathematical set operations for arrays.

=head1 SYNOPSIS

  # Assuming path to module is ./lib/Utils/Arrays/Sets.pm
  use lib 'lib';
  use Utils::Arrays::Sets qw(union);

  my @arr1 = (1, 2, 3, 4);
  my @arr2 = (3, 4, 5, 6);

  my @res = union(\@arr1, \@arr2);

  print "@res\n"; # 1 2 3 4 5 6

=head1 DESCRIPTION

C<Arrays::Sets> is a module providing math set operations for arrays.
It provides functions such as L</union>, which finds the union of two arrays.

=head1 METHODS

=head2 union

Finds the union of both arrays provided, i.e., a collection of all
unique elements present in either array.

=head3 PARAMETERS

=over 4

=item C<$arr1>

A reference to the first array.

=item C<$arr2>

A reference to the second array.

=back

=head3 RETURN VALUE

Returns an array of the two provided arrays'
union elements.

=head1 AUTHOR

Ethan Kletschke (L<mailto:ethankletschke@outlook.com>)

=cut
