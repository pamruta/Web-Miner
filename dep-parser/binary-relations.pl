
# Usage: binary-relations.pl dependency-parser-output

# extracts binary relations from the output of dependendency parser

open(FILE, $ARGV[0]);
while(<FILE>)
{
	chomp;
	# verb-object relation
	if(/dobj\(([A-Za-z]+)\-\d+, ([A-Za-z]+)\-\d+\)/)
	{
		$w1 = $1; $w2 = $2;
		$w1 =~ tr/[A-Z]/[a-z]/;
		$w2 =~ tr/[A-Z]/[a-z]/;
		$freq{"dobj\t$w1 $w2"}++;
	}
	# prepositional relations
	elsif(/nmod:([A-Za-z]+)\(([A-Za-z]+)\-\d+, ([A-Za-z]+)\-\d+\)/)
	{
		$prep = $1; $w1 = $2; $w2 = $3;
		if($prep !~ /^(npmod|poss|tmod)$/)
		{
			$w1 =~ tr/[A-Z]/[a-z]/;
	                $w2 =~ tr/[A-Z]/[a-z]/;
			$freq{"nmod\t$w1 $prep $w2"}++;
		}
	}
	# compound nouns
	elsif(/compound\(([A-Za-z]+)\-\d+, ([A-Za-z]+)\-\d+\)/)
	{
		$w1 = $1; $w2 = $2;
                $w1 =~ tr/[A-Z]/[a-z]/;
                $w2 =~ tr/[A-Z]/[a-z]/;
                $freq{"compound\t$w2 $w1"}++;
	}
	# adjective-noun relation
	elsif(/amod\(([A-Za-z]+)\-\d+, ([A-Za-z]+)\-\d+\)/)
        {
                $w1 = $1; $w2 = $2;
                $w1 =~ tr/[A-Z]/[a-z]/;
                $w2 =~ tr/[A-Z]/[a-z]/;
                $freq{"amod\t$w2 $w1"}++;
        }
}

close FILE;

# printing dependency-relations
foreach $w (sort {$freq{$b} <=> $freq{$a}} keys %freq)
{
	print "$w\t$freq{$w}\n";
}
