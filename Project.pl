#!/usr/bin/perl
use strict;
use warnings;
use utf8;
binmode STDOUT, ':utf8';

my @problems = (
['orange','柑橘類','愛媛が生産一位','冬にこたつの上にある'],
['apple','赤い','あるパソコンのメーカー','スティーブ・ジョブズの設立の会社のロゴ'],
['capacity','これがない人はだめ','日本語でよく、キャ○がないという','意味:度量'],
['minister','国家に関わる','人','意味:大臣'],
['branch','木とか関係ある','木の末端','意味:枝'],
['vote','若者の和が少ない','20才以上で権利がある','意味:投票'],
['resident','多くの人がそう','類語:住民','意味:住民'],
['government','これがないと国家が成り立たない','意味:政府'],
['masterpiece','バッハの創りだしたもの','意味:傑作'],
['test','みんなが受けたことのあるやつ','意味:テスト']);
my $miss_count = 0;
my $i = 1;
my $question_count = @problems;
my $alarm_time = 5;


print "\n英単語を当てるゲームです。\n\n英単語の語の順序がバラバラになっているので、それを正しく順番を直して入力してください。\n\nなお。間違えるとヒントも少しあります。\n\nそれでは10秒後にスタートします。", "\n";
printf "%d秒以内に何か入力して下さい。\n", $alarm_time;
sleep 10;
foreach my $problem(@problems) {
    print " ### 第 ${i}問 ###\n";
    my @qestion = split(//, $problem->[0]);
    foreach(@qestion){
        print $_ , ",";
    }
    print "\n";

    my $action = 'bad';
    my $hint_count = 1;
    eval {
        while ($action ne 'go') {

            # timeout 処理
            local $SIG{ALRM} = sub { die "timeout" };
            alarm $alarm_time;
            my $text = <STDIN>;
            chomp($text);
            alarm 0;

            if ($text eq $problem->[0]) {
                print 'あたりです！',"\n";
                $action = 'go';
            }else{
                print 'ハズレです',"\n";
                if ($hint_count == @$problem - 1) {
                    print 'これで最後のヒントです。';
                    print 'ヒントは、' . $problem->[$hint_count];
                }elsif($hint_count < @$problem){
                    print 'ヒントは、' . $problem->[$hint_count + 1];
                }else{
                    print 'もうヒントはありません。';
                }
                $hint_count++;
                $action = 'bad';
            }
        }
    };
    # evalエラー処理
    if ($@) {
        if ($@ =~ /timeout/) {
            # タイムアウトエラー
            print "タイムアウトです。\n";
            $miss_count++;
        } else {
            # その他のエラー
            alarm 0;
            die $@;
        }
    }
    $i++;
}

my $ans_rate = (($question_count - $miss_count) * 100) / $question_count;
print "終了！\nあなたの正解率は？....${ans_rate}% です〜！","\n";
print $question_count, "\n";
print $miss_count;
