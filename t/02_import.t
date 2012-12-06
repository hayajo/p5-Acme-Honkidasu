#!/usr/bin/env perl
use strict;
use warnings;
use utf8;
binmode Test::More->builder->$_, ":utf8" for qw/output failure_output todo_output/;

use Test::More tests => 60;

use Time::Piece;
use Acme::Honkidasu;

my @honkidasu = <DATA>;
for my $i (1..12) {
    my $t = Time::Piece->strptime(sprintf('%02d', $i), '%m');
    chomp( my $honki = $honkidasu[ $i - 1 ] );
    cmp_ok $t->honkidasu, 'eq', $honki;
    cmp_ok $t->strftime('%!'), 'eq', $honki;
    cmp_ok $t->strftime('%%!%%%'), 'eq', '%!%%';
    cmp_ok $t->strftime('%%%!%%%'), 'eq', "%$honki%%";
    cmp_ok $t->strftime('%%%!%%%%%!%%%'), 'eq', "%$honki%%$honki%%";
}

my $now = localtime;
diag sprintf("【%d月】%s", $now->mon, $now->honkidasu);

__DATA__
初っ端から飛ばすと後でばてる。来月から本気を出す。
まだまだ寒い。これではやる気が出ない。来月から本気出す。
年度の終わりでタイミングが悪い。来月から本気を出す。
季節の変わり目は体調を崩しやすい。来月から本気を出す。
区切りの良い４月を逃してしまった。来月から本気を出す。
梅雨で気分が落ち込む。梅雨明けの来月から本気を出す。
これからどんどん気温が上昇していく。体力温存の為来月から本気を出す。
暑すぎて気力がそがれる。来月から本気を出す。
休みボケが抜けない。無理しても効果が無いので来月から本気を出す。
中途半端な時期。ここは雌伏の時。来月から本気を出す。
急に冷えてきた。こういう時こそ無理は禁物。来月から本気を出す。
もう今年は終わり。今年はチャンスが無かった。来年から本気出す。
