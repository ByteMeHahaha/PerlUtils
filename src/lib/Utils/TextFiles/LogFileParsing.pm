package Utils::TextFiles::LogFileParsing;

use strict;
use warnings;
use Exporter 'import';

our @EXPORT_OK  = qw(count_logs_by_type);

sub count_logs_by_type {
  my ($log_type, $filename) = @_;

  unless (defined($filename)) {
    die "File name not provided";
  }

  open my $fh, "<", $filename
    or die "Cannot open file \"$filename\": $!";

  my %counts;

  while (my $line = <$fh>) {
    chomp($line);

    unless ($line =~ /^\[([a-zA-Z]+)\]/) {
      die "No matching log line\n";
    }

    $counts{$1}++;
  }

  close $fh
    or die "Could not close \"$filename\": $!";

  return $counts{$log_type} // 0;
}

1;
