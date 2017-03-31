
# Usage: extract-compounds.pl dependency-parser-output

# extracts compound nouns from the output of dependendency parser

open(FILE, $ARGV[0]);
while(<FILE>)
{
	chomp;
	# blank line at the end of sentence
	if(/^\s*$/)
	{
		# tokens modified by compounds
		for $ind1 (keys %compound)
		{
			$comp = "";
			# sorting modifiers by index
			for $ind2 (sort keys %{$compound{$ind1}})
			{
				$comp .= "$tokens[$ind2] ";
			}
			$comp .= $tokens[$ind1];
			$freq_compound{$comp}++;
		}
		@tokens = ();
		%compound = ();
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

		# compound nouns
		if($rel eq "compound")
		{
			$compound{$ind1}{$ind2} = 1;
		}
	}
}

close FILE;

# printing compounds
foreach $w (sort {$freq_compound{$b} <=> $freq_compound{$a}} keys %freq_compound)
{
	print "$w\t$freq_compound{$w}\n";
}
