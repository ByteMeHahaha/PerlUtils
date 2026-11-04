package Utils::Strings::Simple;

sub is_empty_str {
  # Parameters
  my ($str) = @_;

  # Trim leading and trailing whitespace from the string
  $str =~ s/^\s+|\s+$//g;

  # Return 1 if the string is empty, or 0 if it isn't
  return $str eq "" ? 1 : 0;
}

1;

__END__
