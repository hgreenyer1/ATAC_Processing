#!/bin/bash 

#mark duplicates with picard - do not remove duplicates 

java -jar /users/h/g/hgreenye/picard/build/libs/picard.jar MarkDuplicates -I $1 -O $2 -M $3
