package Utils::TextFiles::Simple;

use strict;
use warnings;
use Exporter 'import';

our @EXPORT_OK = qw(
  can_open
  cant_open
);

sub can_open {
  my ($filename) = @_;

  open my $fh, '<', $filename or return 0;
  close $fh or die "Can't close $filename: $!";

  return 1;
}

sub cant_open {
  my ($filename) = @_;

  open my $fh, '<', $filename or return 1;
  close $fh or die "Can't close $filename: $!";

  return 0;
}

1;

__END__

=pod

=head1 NAME

C<TextFiles::Simple> - Simple utilities for handling text files.

=head1 SYNPOSIS

  use Utils::TextFiles::Simple qw(can_open);

  unless (can_open("dev.log")) {
    die "Can't open dev.log: $!";
  }

=head1 DESCRIPTION

The C<TextFiles::Simple> module provides utilities for
simple file handling, such as testing if a file can be opened successfully or
testing if it's writable, readable, or a directory.

=for comment
FINISH DOCS LATER

=cut
