
# Usage: extract-modifiers.pl dependency-parser-output

# extracts modifiers from the output of dependendency parser
# this includes compound nouns, plus, the adjectives
# attached to nouns / compounds

open(FILE, $ARGV[0]);
while(<FILE>)
{
	chomp;
	# blank line at the end of sentence
	if(/^\s*$/)
	{
		for $ind1 (keys %modifier)
		{
			$mod = "";
			# sorting tokens by index
			for $ind2 (sort keys %{$modifier{$ind1}})
			{
				$mod .= "$tokens[$ind2] ";
			}
			$mod .= $tokens[$ind1];
			$freq_modifier{$mod}++;
		}
		@tokens = ();
		%modifier = ();
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
	}
}

close FILE;

# printing modifiers
foreach $w (sort {$freq_modifier{$b} <=> $freq_modifier{$a}} keys %freq_modifier)
{
	print "$w\t$freq_modifier{$w}\n";
}
