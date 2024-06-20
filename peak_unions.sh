#!/bin/bash

#get overlapping peaks from two bed files 


bedops --merge $1 $2 > $3"_merge.bed"
bedops --everything $1 $2 > $3"_union.bed"
bedmap --echo --echo-map $3"merge.bed" $3"_union.bed" > $3"_answer.bed"
