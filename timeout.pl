use strict;
use warnings;

my $alarm_time = 5;
printf "%d秒以内に何か入力して下さい。\n", $alarm_time;
eval {
    local $SIG{ALRM} = sub { die "timeout" };

    alarm $alarm_time;
    my $input_string = <>;
    alarm 0;

    chomp $input_string;
    printf "%sが入力されました。\n", $input_string;
};
if ($@) {
    # エラー処理
    if ($@ =~ /timeout/) {
        # タイムアウトエラー
        print "タイムアウトしました。\n";
    } else {
        # その他のエラー
        alarm 0;
        die $@;
    }
}