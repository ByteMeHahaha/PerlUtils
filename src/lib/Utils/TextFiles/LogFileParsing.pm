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

    # If the start of the line doesn't match the regex (see module manual)
    unless ($line =~ /^\[?([a-zA-Z]+)\]?/) {
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
  my ($log_type, $filename) = @_;

  open my $fh, '<', $filename
    or die "Cannot open $filename: $!";

  my @lines = <$fh>;

  close $fh or die "Cannot close $filename: $!";

  # Temporary code
  return "";
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

=for comment
DO THIS LATER

=head1 METHODS

=for comment
Document methods later

=head1 AUTHOR

Ethan Kletschke

=cut
