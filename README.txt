
Use Python Notebook Fetch-HTML.ipynb to fetch an HTML page from a given url,
and convert it to plain-text format. 

File Aniston.txt is created by python script Fetch-HTML.ipynb by fetching
Jennifer Aniston's Wikipedia Page: https://en.wikipedia.org/wiki/Jennifer_Aniston

Download Stanford Parser and CoreNLP library from -

CoreNLP Link - http://stanfordnlp.github.io/CoreNLP/download.html
Stanford-Parser Link - http://nlp.stanford.edu/software/lex-parser.shtml

We have provided here scripts for Phrase and Relation Extraction using -

[1] Phrase-Structure Parser: 

	Directory <phrase-parser> has the code to process the output of stanford-parser
	in Phrase-Structure format. Description of these tags can be found here -
	http://web.mit.edu/6.863/www/PennTreebankTags.html

	=> <run-phrase-parser.sh> runs stanford-parser to create the output in 
	phrase-structure format.

	Usage: ./run-phrase-parser.sh input-file

	=> Output of phrase-parser on Aniston.txt can be found in file: 
	Aniston-Phrase-Parser-Output.txt

	=> Perl script <phrase-extraction.pl> processes parser-output by extracting
	phrases from the parsed text.

	Usage: perl ./phrase-extraction.pl PHRASE-PARSER-OUTPUT

	=> Phrases extracted by <phrase-extraction.pl> on Aniston-Phrase-Parser-Output.txt
	can be found in file: Aniston-Phrase-Table.txt

	Note: the output of <phrase-extraction.pl> is tab-separated and can be easily
	exported to Excel or MySQL database. Simple 'grep' command on this file will extract
	phrases matching given patterns. e.g.

	grep "\tnominated for " Aniston-Phrase-Table.txt
	grep "\tmarried " Aniston-Phrase-Table.txt
	grep "\tlived in " Aniston-Phrase-Table.txt

[2] Dependency Parser:

	Directory <dep-parser> contains scripts for processing the parser-output in 
	typed-dependency format.

	=> run-dep-parser.sh - runs Stanford Parser on given text file, to produce the output
	in dependency format.

	Usage: ./run-dep-parser.sh input-file

	=> Output of dependency parser on sample file Aniston.txt can be found in file:
	Aniston-Dep-Parser-Output.txt

	=> Perl script <binary-relations.pl> processes dependency-parser output by extracting
	binary relations (dependency paths) from the parsed text.

	Usage: binary-relations.pl DEP-PARSER-OUTPUT

	=> Output of <binary-relations.pl> on sample file: Aniston-Dep-Parser-Output.txt is
	stored in file: Aniston-Dep-Paths.txt

	Note: The current version only extracts binary-relations as produced by dependency-parser,
	so multi-word expressions like "actors guild award", "golden globe award" are split into
	binary relations: "guild award", "globe award", "golden award". We are working on fixing
	this issue on high-priority.

[3] OpenIE: http://nlp.stanford.edu/software/openie.html

	OpenIE is already included in Stanford CoreNLP library.
	Directory <open-ie> contains following files:

	=> run-openie.sh - this runs the Stanford OpenIE to extract subject-verb-object
	   patterns from given text.

	   Usage: ./run-openie.sh input-file

	=> File Aniston-OpenIE-Output.txt shows sample phrases extracted by OpenIE on
	   Aniston.txt

	Note: Presently, the coreference resolution is not handled, to resolve pronouns
	like 'She', 'Her' etc. There is an option to do so in Open-IE, but it takes longer
	processing time and memory.
