
Use Python Notebook Fetch-HTML.ipynb to fetch an HTML page from a given url,
and convert it to plain-text format. 

File Aniston.txt is created by python script Fetch-HTML.ipynb by fetching
Jennifer Aniston's Wikipedia Page - https://en.wikipedia.org/wiki/Jennifer_Aniston

Download Stanford Parser and Stanford CoreNLP library from -

CoreNLP Link - http://stanfordnlp.github.io/CoreNLP/download.html
Stanford Parser Link - http://nlp.stanford.edu/software/lex-parser.shtml

We have provided here scripts for Phrase and Relation Extraction using -

[1] Phrase-Structure Parser: 

	Directory phrase-parser has the code to process the output of stanford-parser
	in Phrase-Structure format. Description of these tags can be found here -
	http://web.mit.edu/6.863/www/PennTreebankTags.html

	=> run-phrase-parser.sh runs stanford-parser to create output in phrase-structure
	format.

	Usage: ./run-phrase-parser.sh input-file

	=> Output of Phrase-Parser on Aniston.txt can be found in file: 
	Aniston-Phrase-Parser-Output.txt

	=> Perl script phrase-extraction.pl processes parser-output by extracting all
	phrases from the parsed text.

	Usage: perl ./phrase-extraction.pl PHRASE-PARSER-OUTPUT

	=> Phrases extracted by phrase-extraction.pl on Aniston-Phrase-Parser-Output.txt
	can be found in file: Aniston-Phrase-Table.txt

[2] Dependency Parser:

	Coming Soon ...

[3] OpenIE: http://nlp.stanford.edu/software/openie.html
OpenIE is already included in Stanford CoreNLP library.

Directory open-ie contains files:
	=> run-openie.sh - this runs the Stanford OpenIE to extract subject-verb-object
	   patterns from given text.

	   Usage: ./run-openie.sh input-file

	=> File Aniston-OpenIE-Output.txt shows sample phrases extracted by OpenIE on
	   Aniston.txt
