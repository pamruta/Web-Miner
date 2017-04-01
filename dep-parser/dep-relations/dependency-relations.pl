
# Usage: dependency-relations.pl dependency-parser-output

# extracts dependency-relations from the dependency-parser output
# includes verb-object, adjective-modifier, compound-noun and prepositional relations

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
			$freq_pattern{$mod}++;
		}

		# get token indices with prepositional or verb attachments
		for $ind (keys %attachments)
		{
			# get all attached verbs / prepositions for this index
			for $attach (@{$attachments{$ind}})
			{
				$freq_pattern{"$attach $tokens[$ind]"}++;
			}
		}
		@tokens = ();
		%modifier = ();
		%attachments = ();
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
		# verb-object relations
		elsif($rel eq "dobj")
		{
			push @{$attachments{$ind2}}, $w1;
		}
		# prepositional attachments
		elsif($rel =~ /^nmod:(.*)/)
		{
			$prep = $1;
			if($prep !~ /^(npmod|poss|tmod)$/)
			{
				push @{$attachments{$ind2}}, "$w1 $prep";
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
