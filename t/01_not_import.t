#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode Test::More->builder->$_, ":utf8" for qw/output failure_output todo_output/;

use Test::More tests => 1;

use Time::Piece;
use Acme::Honkidasu ();

my $now       = localtime;
my $honkidasu = Acme::Honkidasu::honkidasu($now);
ok $honkidasu;
