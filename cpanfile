requires 'perl', '5.008001';

requires 'Time::Piece', '>= 1.31';
requires 'POSIX::strftime::GNU';

on 'test' => sub {
    requires 'Test::More', '0.98';
};

