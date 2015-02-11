#!/usr/bin/env perl

#Aggregate CSV from several places

use strict;
use warnings;

use v5.12;

use JSON;

use File::Slurp::Tiny qw(read_file);

my $provincias_content = read_file('poblacion-provincia-INE.csv');
my @provincias = split("\n",$provincias_content);
my @prov_names = split(",",$provincias[0]);
my @prov_pop = split(",",$provincias[1]);

my %new_names = ( "Alicante/Alacant" => "Alicante",
		  "Araba/Álava" => "Álava",
		  "Bizkaia" => "Bilbao",
		  "Castellón/Castelló" => "Castellón",
		  "Gipuzkoa" => "Donostia",
		  "Girona" => "Gerona",
		  "Palmas" => "Las Palmas",
		  "Valencia/València" => "Valencia");

my @columns =  qw( contributions stars followers );

say "province;population;users;",join(";",@columns);
for my $p ( @prov_names ) {
  my $population = shift @prov_pop;
  my $name = $new_names{$p}?$new_names{$p}:$p;
  next if $name eq "Guadalajara"; #Problems with sampling
  my $file_contents = read_file("data/user-data-$name.json");
  next if !$file_contents;
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
  my @row = ( $name, $population, $users );
  for my $column ( @columns ) {
    push @row, $totals->{$column};
  }
  say join(";",@row);
}

