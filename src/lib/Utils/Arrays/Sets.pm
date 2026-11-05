package Utils::Arrays::Sets;

use strict;
use warnings;
use Exporter 'import';

our @EXPORT_OK = qw(
  union
  intersection
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

sub intersection {
  # Parameters
  my ($arr1, $arr2) = @_;

  # Intersection array to return
  my @intersect;

  # Tracking hash to keep track of what elements were encountered
  # in both arrays.
  my %trackingHash;

  # Loop through the first provided array
  foreach my $element (@$arr1) {
    # If the element was not previously encountered
    if (not exists $trackingHash{$element}) {
      # Set it to a true value in the tracking hash
      $trackingHash{$element} = 1;
    }
  }

  # Loop through the second provided array
  foreach my $element (@$arr2) {
    # If the element was found in array 1
    if (exists $trackingHash{$element}) {
      # Remove it from the tracking hash.
      # This prevents duplicate elements in the
      # second array from being added repeatedly
      delete $trackingHash{$element};

      # Add the element to the intersection
      push @intersect, $element;
    }
  }

  # Return the intersection
  return @intersect;
}

sub set_difference {
  # Parameters
  my ($arr1, $arr2) = @_;

  # Result array
  my @diff;
  # Tracking hash
  my %tracking;

  # Iterate through the second array to identify which elements
  # to exclude from $arr1
  foreach my $element (@$arr2) {
    # If the element wasn't encountered yet
    if (not exists $tracking{$element}) {
      # Add it to the tracking hash
      $tracking{$element} = 1;
    }
  }

  foreach my $element (@$arr1) {
    if (not exists $tracking{$element}) {
      # Append the difference to the result array
      push @diff, $element;

      # Add it to the tracking hash to avoid duplicates
      $tracking{$element} = 1;
    }
  }

  # Return the result array
  return @diff;
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

=head2 intersection

Finds the intersection of two arrays, i.e., elements
present in both arrays, excluding duplicate values.

=head3 PARAMETERS

=over 4

=item C<$arr1>

A reference to the first array.

=item C<$arr2>

A reference to the second array.

=back

=head3 RETURN VALUE

Returns a new array containing elements present
in both arrays, without duplicates.

=head3 EXAMPLE USAGE

  my @arr1 = (1, 2, 3, 4);
  my @arr2 = (3, 4, 5, 6);

  my @intersect = intersection(\@arr1, \@arr2);

  print "@intersect\n"; # 3 4

=head1 AUTHOR

Ethan Kletschke (L<mailto:ethankletschke@outlook.com>)

=cut
