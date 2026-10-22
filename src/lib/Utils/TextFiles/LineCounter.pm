package Utils::TextFiles::LineCounter;

use strict;
use warnings;
use Exporter 'import';

# Can specifically choose for import
our @EXPORT_OK = qw(linecount non_empty_linecount);
# Default exports
our @EXPORT = qw(linecount);

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
    # Increase the line count by 1 for each line
    $lc++;
  }

  # Close the file
  close $fh or die "Could not close \"$filename\": $!";

  # Return the line count
  return $lc;
}

sub non_empty_linecount {
}

1;
