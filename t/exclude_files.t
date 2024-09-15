#!perl -T

use strict;
use warnings;

use Test::More tests => 1;

use Test::PerlTidy ();

my @wanted_files = qw(
  Build.PL
  Makefile.PL
  scripts/tag-release.pl
  t/00-compile.t
  t/exclude_files.t
  t/exclude_perltidy.t
  t/is_file_tidy.t
  t/list_files.t
  t/perltidy.t
  t/test_files/cpanfile
  t/test_files/test_app.psgi
);

@wanted_files = map { my $ret = $_; $ret =~ s/\//\\/g; $ret } @wanted_files
  if $^O eq 'MSWin32';

my @found_files = Test::PerlTidy::list_files(
    path    => '.',
    exclude => [ 'blib', 'lib', 'xt', ],
    debug   => 0,
);

# TEST
is_deeply( [ sort @found_files ], \@wanted_files );
