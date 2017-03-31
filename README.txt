
# Information Extraction and Text Mining from Web / Wikipedia

Use python program <fetch-html.py> to fetch an HTML page from a given url,
and convert it to plain-text format.

	Usage: python fetch_html.py WEB_URL

File Aniston.txt is created by script <fetch-html.py> by fetching Jennifer 
Aniston's Wikipedia Page at: https://en.wikipedia.org/wiki/Jennifer_Aniston

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

	=> Perl script <phrase-extraction.pl> processes the parser-output by extracting
	phrases from parsed text.

		Usage: perl ./phrase-extraction.pl PHRASE-PARSER-OUTPUT

	=> Phrases extracted by <phrase-extraction.pl> on Aniston-Phrase-Parser-Output.txt
	can be found in file: Aniston-Phrase-Table.txt

	Note: the output of <phrase-extraction.pl> is tab-separated and can be easily
	exported to Excel or MySQL. Simple 'grep' command on this table will extract
	phrases matching the given patterns. e.g. 

	grep "\tnominated for " Aniston-Phrase-Table.txt
	grep "\tmarried " Aniston-Phrase-Table.txt
	grep "\tlived in " Aniston-Phrase-Table.txt

[2] Dependency Parser:

	Directory <dep-parser> contains scripts for processing the parser-output in 
	typed-dependency format.

	=> run-dep-parser.sh - runs stanford-parser on given text file, to produce the output
	in dependency format.

		Usage: ./run-dep-parser.sh input-file

	=> Output of dependency parser on sample file Aniston.txt can be found in file:
	Aniston-Dep-Parser-Output.txt

	=> dep-parser/README.txt describes various scripts provided in ./dep-parser directory
	to process the output of dependency-parser

[3] OpenIE: http://nlp.stanford.edu/software/openie.html

	OpenIE (stands for Open Information Extraction) is already included in CoreNLP library.
	Directory <open-ie> contains the following files:

	=> run-openie.sh - this runs the Stanford OpenIE program to extract subject-verb-object
	   relations from the given text.

	   	Usage: ./run-openie.sh input-file

	=> File Aniston-OpenIE-Output.txt shows phrases extracted by OpenIE on sample text file:
	   Aniston.txt

	Note: Presently, the coreference resolution is not handled, to resolve pronouns or 
	references like 'She', 'Her father' etc. There is an option to do so in Open-IE.
