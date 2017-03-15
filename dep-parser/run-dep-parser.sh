#!/bin/csh

#Usage: run-dep-parser.sh input-file

set stanford_parser = "/Users/pamruta/Downloads/stanford-parser-full-2016-10-31"

java -mx500m -cp "$stanford_parser/*" edu.stanford.nlp.parser.lexparser.LexicalizedParser -outputFormat "typedDependencies" edu/stanford/nlp/models/lexparser/englishRNN.ser.gz $1
