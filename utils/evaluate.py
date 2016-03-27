#!/usr/bin/env python
"""
This script is used for evaluating the part of speech tagger where first column contains gold tags and second colum contains predicted tags.
I provides the overall acuuracy along with tag wise accuracy.

Usage:
	python evaluate.py <file1>
"""
import sys
f=open(sys.argv[1],'r')
count=0
match_count=0
match={}
acc={}
for line in f:
	line=line.strip()
	if line == "":
		continue
	result=line.split('\t')
	if len(result)<2:
		continue
	if result[0] not in acc:
		acc[result[0]]=0
		match[result[0]]=0
	if result[0]==result[1]:
		match[result[0]]+=1
		match_count+=1

	acc[result[0]]+=1
	count+=1

print "Accuracy = %d/%d = %f" %(match_count,count,float(match_count)/float(count))

for key,value in match.items():
	print "Tag %s : %d/%d = %f" %(key, value,acc[key], float(value)/float(acc[key]))
