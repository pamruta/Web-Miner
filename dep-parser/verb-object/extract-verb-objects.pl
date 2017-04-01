
# Usage: extract-verb-objects.pl dependency-parser-output

# extracts verb-object relations
# e.g. "won golden globe award", "founded film production company"

open(FILE, $ARGV[0]);
while(<FILE>)
{
	chomp;
	# blank line at the end of sentence
	if(/^\s*$/)
	{
		# tokens modified by adjectives / compounds
		foreach $ind1 (keys %modifier)
		{
			$mod = "";
			# sorting modifiers by index
			foreach $ind2 (sort keys %{$modifier{$ind1}})
			{
				$mod .= "$tokens[$ind2] ";
			}
			$mod .= $tokens[$ind1];
			# replace token with new modifier string
			$tokens[$ind1] = $mod;
		}

		# get token indices with verb attachments
		foreach $ind (keys %verbs)
		{
			# get all attached verbs for this index
			foreach $verb (@{$verbs{$ind}})
			{
				$freq_verb{"$verb\t$tokens[$ind]"}++;
			}
		}
		@tokens = ();
		%modifier = ();
		%verbs = ();
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
			push @{$verbs{$ind2}}, $w1;
		}
	}
}

close FILE;

# printing verb-relations
foreach $w (sort {$freq_verb{$b} <=> $freq_verb{$a}} keys %freq_verb)
{
	print "$w\t$freq_verb{$w}\n";
}
