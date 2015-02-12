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

my %users;
for my $p ( @prov_names ) {
  my $population = shift @prov_pop;
  my $name = $new_names{$p}?$new_names{$p}:$p;
  next if $name eq "Guadalajara"; #Problems with sampling
  my $file_contents = read_file("data/user-data-$name.json");
  next if !$file_contents;
  my $p_data = decode_json( $file_contents);

  for my $u (@$p_data ) {
      if (! $users{$u->{'login'}} ) {
	  for my $column ( @columns ) {
	    if ( $u->{$column} ) {
	      $users{$u->{'login'}}->{$column} += $u->{$column};
	    }
	  }
	  $users{$u->{'login'}}->{'province'} = $name;
      }
  }
}

say "user;province;",join(";",@columns);
for my $k ( sort { $users{$b}->{'contributions'} <=> $users{$a}->{'contributions'} } keys %users ) {
  my @column_values;
  for my $column ( @columns ) {
    if ( $users{$k}->{$column} ) {
      push @column_values, $users{$k}->{$column};
    } else {
      push @column_values, 0;
    }
  }
  say "$k; $users{$k}->{'province'};", join(";", @column_values );
}

