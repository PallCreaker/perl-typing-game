print "難易度を設定できます。1:かんたん。２:ふつう。3:むずかしい。4:おに。\n [1/2/3/4]で入力してください。\n";
while(my $rank_select = <STDIN> ){
    if ($rank_select !~ /^[1-4]/ ) {
        print "[1/2/3/4]で入力してください。\n 1:かんたん。２:ふつう。3:むずかしい。4:おに。\n";
    }else{
        print $rank_select;
        last;
    }
}