package File::SearchPath;

require 5.005_62;		# not necessarily true, blame h2xs
use strict;
use warnings;

use File::Spec::Functions qw(catfile);

require Exporter;

our @ISA = qw(Exporter);

# Items to export into callers namespace by default. Note: do not export
# names by default without a very good reason. Use EXPORT_OK instead.
# Do not simply export all your public functions/methods/constants.

our @EXPORT = qw(searchpath);

our $VERSION = '0.01';

# the main (one) function.
sub searchpath {
    my $file = shift;
    my $path = shift;

    my @path = split(':', $path);

    foreach (@path) {
	my $test = catfile($_,$file);
	return $test if (-e $test && -f $test && -r $test);
    }
    return undef;
}

	
	
1;
__END__

=head1 NAME

File::SearchPath - Search a UNIX style path for a file.

=head1 SYNOPSIS

  use File::SearchPath;
  $fullpathtofile = searchpath($filename, $path);

=head1 DESCRIPTION

contains only one function, searchpath, which is exported by default.

=item searchpath

=over 2

accepts a file name and a UNIX style (colon delimited) path to search
for that file.

It will only return a successful path if the file exists, is a file,
and is readable.

=head1 RETURN

returns undef if the search fails.

returns the full path to the file otherwise.

=back

=head1 EXAMPLE

perl -MFile::SearchPath -wle'print searchpath(q{ls},$ENV{PATH})'


    use File::SearchPath;
    searchpath("cat",$ENV{PATH});

=head1 EXPORTS

searchpath()

=head1 AUTHOR

Robert Spier <RSPIER@cpan.org>

=head1 SEE ALSO

File::Find

=cut
