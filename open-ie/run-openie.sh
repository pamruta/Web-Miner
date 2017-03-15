#!/bin/csh

# Usage: ./run-openie.sh input-file

set stanford_corenlp = "/Users/pamruta/Downloads/stanford-corenlp-full-2016-10-31"

java -mx2g -cp "$stanford_corenlp/*" edu.stanford.nlp.naturalli.OpenIE -format "default" $1
