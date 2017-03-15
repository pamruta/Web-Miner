
#input: output of Stanford Parser in phrase-structure format

open(PHRASE, $ARGV[0]);

while(<PHRASE>)
{
	chomp;
	@open_phrases = ();
	@open_tags = ();
	@tokens = split(/ /);
	foreach $token (@tokens)
	{
		if($token =~ /\((.*)/)
		{
			push @open_tags, $1;
			push @open_phrases, "";
		}
		elsif($token =~ /([^\)]+)(\)+)/)
		{
			$w = $1;
			$close_brackets = $2;
			$w =~ s/^\-LRB\-$/\(/;
                        $w =~ s/^\-RRB\-$/\)/;
			$w =~ tr/[A-Z]/[a-z]/;
			foreach $i (0 .. scalar(@open_phrases)-1)
			{
				if($open_phrases[$i] eq "")
				{
					$open_phrases[$i] = $w;
				}
				else
				{
					$open_phrases[$i] .= " $w";
				}
			}
			while($close_brackets =~ /\)/)
			{
				$close_brackets = $';
				$tag = pop @open_tags;
				$phrase = pop @open_phrases;
				if($phrase =~ / /)
				{
					print "$tag\t$phrase\n";
				}
				if($tag eq "ROOT")
				{
					print "\n";
				}
			}
		}
	}
	if(scalar @open_tags > 0 || scalar @open_phrases > 0)
	{
		print STDERR "Mismatching Tags or Brackets Found.\n";
		exit 1;
	}
}

close PHRASE;
