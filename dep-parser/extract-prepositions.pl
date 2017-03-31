
# Usage: extract-prepositions.pl dependency-parser-output

# extracts prepositions from the output of dependendency parser
# includes prepositions attached to simple or compound nouns
# along with adjective modifiers, if any

# e.g. daughter of greek-born actor john aniston
# has a preposition "daughter-of" attached to compound-noun 
# "greek-born actor john aniston"

open(FILE, $ARGV[0]);
while(<FILE>)
{
	chomp;
	# blank line at the end of sentence
	if(/^\s*$/)
	{
		# tokens modified by adjectives / compounds
		for $ind1 (keys %modifier)
		{
			$mod = "";
			# sorting modifiers by index
			for $ind2 (sort keys %{$modifier{$ind1}})
			{
				$mod .= "$tokens[$ind2] ";
			}
			$mod .= $tokens[$ind1];
			# replace token with new modifier string
			$tokens[$ind1] = $mod;
		}

		# finding token indices with prepositional attachments
		for $ind (keys %preposition)
		{
			# get all prepositions attached to this index
			for $prep (@{$preposition{$ind}})
			{
				$freq_preposition{"$prep\t$tokens[$ind]"}++;
			}
		}
		@tokens = ();
		%modifier = ();
		%preposition = ();
	}
	elsif(/(.*)\((.*)\-(\d+), (.*)\-(\d+)\)/)
	{
		$rel = $1;
		$ind1 = $3; $ind2 = $5;
		$w1 = $2; $w2 = $4;
		$w1 =~ tr/[A-Z]/[a-z]/;
		$w2 =~ tr/[A-Z]/[a-z]/;
		# storing tokens in the current sentence by index
		if(!defined $tokens[$ind1])
		{
			$tokens[$ind1] = $w1;
		}
		if(!defined $tokens[$ind2])
		{
			$tokens[$ind2] = $w2;
		}

		# compounds and adjectives
		if($rel eq "compound" || $rel eq "amod")
		{
			$modifier{$ind1}{$ind2} = 1;
		}
		# prepositions
		elsif($rel =~ /^nmod:(.*)/)
		{
			$prep = $1;
			if($prep !~ /^(npmod|poss|tmod)$/)
			{
				push @{$preposition{$ind2}}, "$w1 $prep";
			}
		}
	}
}

close FILE;

# printing prepositions
foreach $w (sort {$freq_preposition{$b} <=> $freq_preposition{$a}} keys %freq_preposition)
{
	print "$w\t$freq_preposition{$w}\n";
}
