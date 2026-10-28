package Utils::TextFiles::LineCounter;

use strict;
use warnings;
use Exporter 'import';

# Specifies what's okay for importing
our @EXPORT_OK = qw(
  linecount
  non_empty_linecount
);

sub linecount {
  # Extract the filename from the arguments list
  my ($filename) = @_;

  # If the file doesn't exist
  unless (-e $filename) {
    # Return the line count as zero
    return 0;
  }

  # Open the specified file for reading ('<')
  open my $fh, '<', "$filename"
    or die "Cannot open file \"$filename\": $!";

  # Declare a variable for the line count
  my $lc = 0;

  # Loop through the file's individual lines
  while (my $line = <$fh>) {
    # Remove the \n from the line
    chomp($line);
    # Increase the line count by 1 for each line
    $lc++;
  }

  # Close the file
  close $fh or die "Could not close \"$filename\": $!";

  # Return the line count
  return $lc;
}

sub non_empty_linecount {
  # Extract the filename parameter from the provided arguments list
  my ($filename) = @_;

  # If the file doesn't exist
  unless (-e $filename) {
    # Return a linecount of 0
    return 0;
  }

  # Open the specified file
  open my $fh, '<', $filename or die "Could not open \"$filename\": $!";

  # Initialise the line count variable
  my $lc = 0;

  # Loop through the file
  while (my $line = <$fh>) {
    # Remove the trailing newline character from the line read
    # from the file
    chomp($line);

    # Only increase the linecount by 1 if the length of the line
    # isn't 0
    $lc++ if length($line);
  }

  # Close the file
  close $fh or die "Could not close \"$filename\": $!";

  # Return the linecount
  return $lc;
}

1;

__END__

=pod

=head1 NAME

C<LineCounter> - A file parsing module for counting lines in files.

=head1 SYNOPSIS

  use Utils::TextFiles::LineCounter qw(non_empty_linecount);

  print non_empty_linecount('dev.log'), "\n";

=head1 DESCRIPTION

The C<LineCounter> module provides utility functions for counting lines in files.

=head1 METHODS

=head2 linecount

Counts the number of lines in a text file. Also counts blank lines.

=head3 PARAMETERS

=over 4

=item C<$filename>

The name of the file whose lines to count.

=back

=head3 RETURN VALUE

Returns an integer representing the line count for that file, or
C<0> if the file doesn't exist.

=head3 ERROR HANDLING

If the file specified by C<$filename> cannot be opened or closed correctly,
the function calls C<die>. This behaviour is subject to change.

=head3 EXAMPLE USAGE

  use Utils::TextFiles::LineCounter qw(linecount);

  print linecount('dev.log'), "\n";

=head2 non_empty_linecount

Performs the same line-counting as L</linecount>, but
doesn't count empty lines.

=head3 PARAMETERS

=over 4

=item C<$filename>

The name of the file whose lines are to be counted.

=back

=head3 RETURN VALUE

Returns an integer representing the count of non-empty lines for
C<$filename>.

=head3 ERROR HANDLING

If the file specified by C<$filename> cannot be opened or closed correctly,
the function calls C<die>. This behaviour is subject to change.

=head3 EXAMPLE USAGE

  use Utils::TextFiles::LineCounter qw(non_empty_linecount);

  print non_empty_linecount('dev.log'), "\n";

=head1 AUTHOR

Ethan Kletschke

=cut
