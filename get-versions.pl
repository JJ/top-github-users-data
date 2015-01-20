#!/usr/bin/env perl

use strict;
use warnings;

use v5.12;

use JSON;
use Git;

my $file = shift || die "Uso: $0 <fichero>\n";
my $dir = shift || ".";

my $repo = Git->repository (Directory => $dir);


my @revs = $repo->command('rev-list', '--all', '--', $file);
my @data;
my @columns =  qw( contributions stars followers );
say join(";",@columns);

for my $commit ( reverse @revs ) {
    my $file_contents = $repo->command('show',"$commit:$file" );
    my $user_data = decode_json( $file_contents);
    my $totals = { contributions => 0,
		   stars => 0,
		   followers => 0};
    my $users = 0;
    for my $u (@$user_data ) {
      $users++;
      for my $column ( @columns ) {
	$totals->{$column} += $u->{$column}
      }
    }
    my @row = ( $users );
    for my $column ( @columns ) {
      push @row, $totals->{$column};
    }
    say join(";",@row);
}




