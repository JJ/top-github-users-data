#!/usr/bin/env perl

use strict;
use warnings;

use v5.12;

use Git;
use File::Slurp::Tiny qw(read_lines);

my $file = shift || die "Usage: $0 <fichero> [git directory] [Baseline file (not in repo)]\n";
my $dir = shift || ".";
my $baseline = shift; 

my $repo = Git->repository (Directory => $dir);

my @revs = $repo->command('rev-list', '--all', '--', $file);
my @data;

my @columns = qw( followers contributions stars );

my %column_row =  ( followers => 2,
		    contributions => 3,
		    stars => 4 );

say "users;",join(";",@columns);

#For files not in repo
if ($baseline) {
      my @file_contents = read_lines( $baseline );
      my @row = extract_data( @file_contents);
      say scalar @file_contents,";",join(";",@row);
}

for my $commit ( reverse @revs ) {
  my $file_contents = $repo->command('show',"$commit:$file" );
  my @file_lines = split("\n",$file_contents);
  my @row = extract_data(@file_lines );
  say scalar @file_lines,";",join(";",@row);
}


#Extract data from JSON
sub extract_data {
  my @lines = @_;
  my $totals = {};
  if ( $lines[0] !~ /place/ ) { # Hack for initial format
    %column_row =  ( followers => 2,
		     contributions => 3,
		     stars => 4 );
  } else {
    %column_row =  ( followers => 3,
		     contributions => 4,
		     stars => 5 );
  }
  for my $c (@columns) {
    $totals->{$c} = 0;
  }
  
  for my $u (@lines[1..$#lines] ) {
    my @row = split(";",$u);
    for my $column ( @columns ) {
      $totals->{$column} += $row[$column_row{$column}] || 0;
    }
  }
  my @row;
  for my $column ( @columns ) {
    push @row, $totals->{$column};
  }
  return @row;
}

