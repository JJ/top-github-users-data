#!/usr/bin/env perl

use strict;
use warnings;

use v5.12;

use JSON;
use Git;
use File::Slurp::Tiny qw(read_file);

my $file = shift || die "Uso: $0 <fichero>\n";
my $dir = shift || ".";
my $baseline = shift; 

my $repo = Git->repository (Directory => $dir);


my @revs = $repo->command('rev-list', '--all', '--', $file);
my @data;
my @columns =  qw( contributions stars followers );
say "users;",join(";",@columns);

#For files not in repo
if ($baseline) {
  my $file_contents = read_file( $baseline );
  my @row = extract_data( $file_contents);
  say join(";",@row);
}

for my $commit ( reverse @revs ) {
  my $file_contents = $repo->command('show',"$commit:$file" );
  my @row = extract_data( $file_contents);
  say join(";",@row);
}


#Extract data from JSON
sub extract_data {
  my $file_contents = shift;
  my $user_data = decode_json( $file_contents);
  my $totals = {};
  for my $c (@columns) {
    $totals->{$c} = 0;
  }

  my $users = 0;
  for my $u (@$user_data ) {
    $users++;
    for my $column ( @columns ) {
      ( $totals->{$column} += $u->{$column} ) if $u->{$column};
    }
    say "$u->{login} $totals->{stars}";
  }
  my @row = ( $users );
  for my $column ( @columns ) {
    push @row, $totals->{$column};
  }
  return @row;
}

