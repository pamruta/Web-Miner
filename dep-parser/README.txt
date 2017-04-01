
	Author: Amruta Purandare
	Last Updated: Apr 1, 2017

Description: This README file describes various scripts provided in
the current directory /dep-parser to extract phrases from the output 
of stanford dependency-parser.

To illustrate, we have created the output of dependency-parser on
sample file, Aniston.txt. The script <run-dep-parser.sh> runs stanford
parser on the input text-file, and produces the output in typed-dependency
format. The output of <run-dep-parser.sh> on sample file Aniston.txt
can be found in: Aniston-Dep-Parser-Output.txt

The code provided here is split into separate directories, based on
the type of relationships they extract from the dependency-output.

binary: extracts simple binary-relations as given by dependency-parser,
e.g. "brad pitt", "courtney cox", "golden globe", "horrible bosses",
"box office", "universal pictures", "romantic comedy" etc.

The following directories provide the code to extract longer-phrases
beyond two-words.

compounds: extracts compound-nouns like "box office success", "primetime
emmy award", "screen actors guild award", "new york city", "toronto
international film festival" etc..

modifiers: extracts nouns modified by either compounds or adjectives,
e.g. "greek-born actor john aniston", "most beautiful woman", "outstanding
guest actress", "american actress nancy dow" etc.

prepositions: extracts prepositional-patterns like "nominated for golden
globe award", "starred opposite ben affleck", "daughter of american actress
nancy dow", "appeared in many tv commercials" etc.

verb-obect: extracts verb-object relations like "founded film production
company", "earned primetime emmy award", "gained world-wide recognition"..

dep-relations: includes all of the above
