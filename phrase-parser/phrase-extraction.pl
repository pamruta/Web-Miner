
# Input: output of Stanford Parser in phrase-structure format
# Usage: perl phrase-extraction.pl PHRASE-PARSER-OUTPUT

open(PHRASE, $ARGV[0]);

while(<PHRASE>)
{
	chomp;
	@open_phrases = ();
	@open_tags = ();
	@tokens = split(/ /);
	foreach $token (@tokens)
	{
		# open round bracket indicates new tag
		if($token =~ /\((.*)/)
		{
			push @open_tags, $1;
			push @open_phrases, "";
		}
		# close round bracket marks end of tag
		elsif($token =~ /([^\)]+)(\)+)/)
		{
			$w = $1;
			$close_brackets = $2;
			$w =~ s/^\-LRB\-$/\(/;
                        $w =~ s/^\-RRB\-$/\)/;
			$w =~ tr/[A-Z]/[a-z]/;
			# add token w to all open phrases
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
			# each closing bracket marks the end of tag / phrase
			while($close_brackets =~ /\)/)
			{
				$close_brackets = $';
				$tag = pop @open_tags;
				$phrase = pop @open_phrases;
				# printing phrases with at least 2 words
				# to avoid single words
				if($phrase =~ / /)
				{
					print "$tag\t$phrase\n";
				}
				# ROOT marks the end of sentence
				if($tag eq "ROOT")
				{
					print "\n";
				}
			}
		}
	}
	# at the end of the sentence, these arrays should be empty
	if(scalar @open_tags > 0 || scalar @open_phrases > 0)
	{
		print STDERR "Mismatching Tags or Brackets Found.\n";
		exit 1;
	}
}

close PHRASE;
