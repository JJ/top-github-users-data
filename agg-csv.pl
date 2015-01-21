#!/usr/bin/env perl

#Aggregate CSV from several places

use strict;
use warnings;

use v5.12;

use JSON;

use File::Slurp::Tiny qw(read_file);

my @columns =  qw( contributions stars followers );
my @provincias = qw(Madrid Barcelona Valencia Alicante Sevilla Málaga Murcia 
Cádiz Bilbao Coruña Baleares Asturias Tenerife Zaragoza 
Pontevedra Granada Tarragona Córdoba Gerona);

push @provincias, "Las Palmas"; 

say "province;users;",join(";",@columns);
for my $p ( @provincias ) {
  my $file_contents = read_file("data/user-data-$p.json");
  my $p_data = decode_json( $file_contents);
  my $totals = {};
  for my $c (@columns) {
    $totals->{$c} = 0;
  }

  my $users = 0;
  for my $u (@$p_data ) {
    $users++;
    for my $column ( @columns ) {
      ( $totals->{$column} += $u->{$column} ) if $u->{$column};
    }
  }
  my @row = ( $p, $users );
  for my $column ( @columns ) {
    push @row, $totals->{$column};
  }
  say join(";",@row);
}

