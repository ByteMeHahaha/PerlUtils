package Utils::TextFiles::LogFileParsing;

use strict;
use warnings;
use Exporter 'import';

# Exports
our @EXPORT_OK = qw(
  count_logs_by_type
  filter_logs
);

sub count_logs_by_type {
  # Extract the parameters from the arguments list
  my ($log_type, $filename) = @_;

  # If the filename is not provided as an argument
  unless (defined($log_type) && defined($filename)) {
    # Abort the app (Temporary Code)
    die "File name not provided";
  }

  # Open the specified log file for reading ('<')
  open my $fh, "<", $filename
    or die "Cannot open file \"$filename\": $!";

  # Declare a hash of the log type counts
  my %log_count;

  while (my $line = <$fh>) {
    # Remove the newline character from the end of $line
    chomp($line);

    # If the start of the line doesn't match the regex (see module POD)
    unless ($line =~ /^\[?([a-z]+)\]?:?/i) {
      # Abort the program (temporary code)
      die "No matching log line";
    }

    # Increase the count of the extracted log type
    $log_count{$1}++;
  }

  # Close the log file
  close $fh or die "Could not close \"$filename\": $!";

  # Return the count of the log type or 0
  return $log_count{$log_type} // 0;
}

sub filter_logs {
  # Parameters
  my ($log_type, $filename) = @_;

  # If the log type or filename are not provided
  unless (defined $log_type && defined $filename) {
    # Return a falsy value to indicate failure
    return "";
  }

  # If the file provided doesn't exist
  unless (-e $filename) {
    # Return a falsy value to indicate failure
    return "";
  }

  # Open the specified file
  open my $fh, '<', $filename
    or die "Cannot open $filename: $!";

  # Read the file into the @lines array
  my @lines = <$fh>;

  # Close the file
  close $fh or die "Cannot close $filename: $!";

  # Return the lines that start with the log type provided
  # (see POD documentation for explanation on RegEx)
  return grep { /^\[?$log_type\]?:?/i } @lines;
}

1;

__END__

=pod

=head1 NAME

C<LogFileParsing> - A file parsing module for log files.

=head1 SYNOPSIS

  use Utils::TextFiles::LogFileParsing qw(count_logs_by_type);

  my $count = count_logs_by_type('ERR', 'app.log');

  print "$count\n";

=head1 DESCRIPTION

The C<LogFileParsing> module provides utility functions for parsing, handling,
and using log files.

=head1 METHODS

=head2 count_logs_by_type

Counts the number of logs of a certain type in a
provided log file.

Each line is tested against the RegEx C</^\[?([a-z]+)\]?:?/i>, which
allows for the following log types as line prefixes:

=over 4

=item * C<[LOG]>

=item * C<Log:>

=item * C<[LOG]:>

=item * C<[log]>

=back

=head3 PARAMETERS

=over 4

=item C<$log_type>

The type of log to count.

=item C<$filename>

The relative path to the log file, including the file extension.

=back

=head3 ERROR HANDLING

If the file specified with C<$filename> doesn't exist, the method
currently calls C<die> with a stack trace. This behaviour is subject
to change.

=head3 LIMITATIONS

The log type passed to the function has to include only the text
of the log type. For example, if the file includes
C<[ERR]>, the input must be passed without the square
brackets, i.e., C<ERR>.

=head3 EXAMPLE USAGE

  use Utils::TextFiles::LogFileParsing qw(
    count_logs_by_type
  );

  print count_logs_by_type("ERR", "dev.log"), "\n";

=head2 filter_logs

Filters a log file by a specific log type.

Each log line is tested against the RegEx C</^\[?$log_type\]?:?/i>,


=head3 PARAMETERS

Test

=head3 LIMITATIONS

Unlike with L</count_logs_by_type>, you can pass C<[ERR]> for the log type,
and it will work the same as passing C<ERR>. This is due to the use of
L<perlfunc/"grep">.

=head1 AUTHOR

Ethan Kletschke

=cut
