#!/usr/bin/env perl

use strict;
use warnings;
use v5.14;
use File::Slurp::Tiny qw(read_lines);

my $file_name = shift || "../data/processed/aggregated-top-Spain.csv";

my @lines = read_lines($file_name);

die "Empty,file" if !@lines;

say "Scope,language";
for my $l ( @lines[1..$#lines]) {
  chomp($l);
  my @cols = split(";", $l );
  next if !$cols[7];
  my @languages = split(/\s+and\s+/, $cols[7] );
  for my $lang ( @languages ) {
    say "$cols[2],$lang";
  }
}
