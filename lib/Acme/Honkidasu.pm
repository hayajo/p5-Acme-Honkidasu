use strict;
use warnings;

{
    package Acme::Honkidasu;
    use utf8;
    our $VERSION = '0.01';

    use Time::Piece ();

    our $list_honkidasu = [qw/
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
    our $list_honkidasu_positive = [qw/
    年の初めだしスタートダッシュで本気出す
    ２月は短いから無駄にしないために本気出す
    年度の変わり目だから最後の追い込みで本気出す
    春は心機一転新しい環境に早く慣れるために本気出す
    落ち込みやすい時期だから油断しないためにも本気出す
    今は梅雨時期だからこそ他の人に差をつけるために本気出す
    カラっといい天気で活力がみなぎるからこそ今まで以上に本気出す
    暑さで気がたるみがちだけど折角盆休みがある今だからこそ本気出す
    気温も落ち着いて活動しやすい時期になってきたしこれから先も本気出す
    寒くなる年末がくる前に面倒なことは片付けておきたいと思うから本気出す
    冷えてきたけど余裕のある年末をこれから迎えるために今の内から本気出す
    今年の締めだからこそ最後まで気を抜かずに今年を１年にするために本気出す
    /];

    sub import { shift; @_ = ('Time::Piece', @_); goto &Time::Piece::import }
}

{
    package Time::Piece;

    BEGIN {
        no strict 'refs';
        no warnings "redefine";
        my $orig_time_piece_strftime = \&Time::Piece::strftime;
        *{'Time::Piece::strftime'} = sub {
            my ($self, $format) = @_;
            $format =~ s/%%/%%%%/g if ($format);;
            my $str = $orig_time_piece_strftime->($self, $format);
            $str =~ s/((%*)%(\+)?!)/(length($2) % 2) ? $1 : $2 . $self->honkidasu($3)/ge;
            $str =~ s/%%/%/g;
            return $str;
        };
    }

    sub honkidasu {
        my $self     = shift;
        my $positive = shift;
        my $list
            = ($positive)
            ? $Acme::Honkidasu::list_honkidasu_positive
            : $Acme::Honkidasu::list_honkidasu;
        return '' unless (@$list);
        my $idx = ( $self->mon % scalar(@$list) ) - 1;
        chomp( my $msg = $list->[$idx] );
        return $msg;
    }
}

1;
__END__

=encoding utf8

=head1 NAME

Acme::Honkidasu - 本気出すコピペ

=head1 SYNOPSIS

  use 5.010;
  binmode STDOUT, 'utf8';
  use Acme::Honkidasu;
  my $time = localtime;
  say $time->honkidasu;
  say $time->strftime('%F %!');

=head1 DESCRIPTION

Acme::Honkidasu is 本気出す。

=head1 METHOD

=head2 honkidasu

  use Acme::Honkidasu;
  my $time = localtime;
  say $time->honkidasu;
  # say $time->honkidasu(1);

本気出す。

=head1 EXTEND strftime

  use Acme::Honkidasu;
  my $time = localtime;
  say $time->strftime('%F %!');
  # say $time->strftime('%F %+!');

add conversion specifier character '%!' to 本気出す。

=head1 AUTHOR

hayajo E<lt>hayajo@cpan.orgE<gt>

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
