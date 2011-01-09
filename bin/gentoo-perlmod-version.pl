#!/usr/bin/env perl

use strict;
use warnings;

use Gentoo::PerlMod::Version qw( :all );

my $lax = 0;

for (@ARGV) {
  if ( $_ =~ /^--?h/ ) {
    die <<"EOF";

    gentoo-perlmod-version.pl 1.4 1.5 1.6
    gentoo-perlmod-version.pl --lax=1 1.4_5 1.5_6
    gentoo-perlmod-version.pl --lax=2 1.4.DONTDOTHISPLEASE432

    echo 1.4 | gentoo-perlmod-version.pl
    echo 1.4-5 | gentoo-perlmod-version.pl --lax=1
    echo 1.4.NOOOOO | gentoo-perlmod-version.pl --lax=2

EOF

  }
}
for ( 0 .. $#ARGV ) {

  if ( $ARGV[$_] =~ /^--lax=(\d+)$/ ) {
    $lax = 0 + $1;
    splice( @ARGV, $_, 1, () );
    last;
  }
}

if (@ARGV) {
  for (@ARGV) {
    print "$_ => " . gentooize_version( $_, { lax => $lax } );
    print "\n";
  }
}
else {
  while (<>) {
    chomp;
    print "$_ => " . gentooize_version( $_, { lax => $lax } );
    print "\n";
  }
}
