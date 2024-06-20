#!/bin/bash 

for I in *.sam
do
   ALLREADS=$(grep -c 'chr*' $I)
   MITOREADS=$(grep -c 'chrM' $I)

   echo $I
   echo $MITOREADS/$ALLREADS
done 
