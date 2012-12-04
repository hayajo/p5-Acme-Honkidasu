package Acme::Honkidasu;
use strict;
use warnings;
use utf8;
our $VERSION = '0.01';

use Time::Piece ();

use constant LIST_HONKIDASU => [qw/
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
/];

my $orig_time_piece_strftime = \&Time::Piece::strftime;

sub import {
    no strict 'refs';
    no warnings "redefine";
    *{"Time::Piece::honkidasu"} = \&honkidasu;
    *Time::Piece::strftime = sub {
        my ($time, $format) = @_;
        $format =~ s/%%/%%%/g if ($format);;
        my $str = $orig_time_piece_strftime->($time, $format);
        $str =~ s/(?<!%)%!/LIST_HONKIDASU()->[$time->_mon]/ge;
        $str =~ s/%%/%/g;
        return $str;
    };
}

sub honkidasu {
    my $time = shift;
    return LIST_HONKIDASU->[ $time->_mon ];
}

1;
__END__

=encoding utf8

=head1 NAME

Acme::Honkidasu - 本気出すコピペ

=head1 SYNOPSIS

  use 5.010;
  use Time::Piece;
  use Acme::Honkidasu;
  binmode STDOUT, 'utf8';

  my $now = localtime;
  say $now->honkidasu;
  say $now->strftime('%F %!');

=head1 DESCRIPTION

Acme::Honkidasu is 来月から本気を出す。

=head1 METHOD

=head2 honkidasu

    say localtime->honkidasu;

    # or

    my $now = localtime;
    say Acme::Honkidasu::honkidasu($now);

来月から本気だす。

=head1 EXTEND strftime

    say localtime->strftime('%F %!');

add conversion specifier character '%!' to 来月から本気を出す。

=head1 AUTHOR

hayajo E<lt>hayajo@cpan.orgE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
