
# Usage: dependency-relations.pl dependency-parser-output

# extracts dependency-paths from the dependency-parser output

open(FILE, $ARGV[0]);
while(<FILE>)
{
	chomp;
	# blank line at the end of sentence
	if(/^\s*$/)
	{
		# finding tokens which are modified 
		for $ind1 (keys %modifier)
		{
			$mod = "";
			# sorting tokens by index
			for $ind2 (sort keys %{$modifier{$ind1}})
			{
				$mod .= "$tokens[$ind2] ";
			}
			$mod .= $tokens[$ind1];
			# replace token with new modifier string
			$tokens[$ind1] = $mod;
			$freq_pattern{$mod}++;
		}

		# finding token indices with prepositional attachments
		for $ind (keys %preposition)
		{
			# get each preposition attached to this index
			for $prep (@{$preposition{$ind}})
			{
				$freq_pattern{"$prep $tokens[$ind]"}++;
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

# printing dependency paths 
foreach $w (sort {$freq_pattern{$b} <=> $freq_pattern{$a}} keys %freq_pattern)
{
	print "$w\t$freq_pattern{$w}\n";
}
