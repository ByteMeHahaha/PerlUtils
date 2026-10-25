package Utils::TextFiles::LineCounter;

use strict;
use warnings;
use Exporter 'import';

# Can specifically choose for import
our @EXPORT_OK = qw(linecount non_empty_linecount);

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
