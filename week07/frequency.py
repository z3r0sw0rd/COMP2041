#!/usr/bin/python3

import re
import sys
import glob

word = sys.argv[1].lower()
n_matches = {}
n_words = {}

for file in glob.glob("lyrics/*.txt"):
   f = open(file, "r")

   count = 0
   total = 0
   words = []

   for line in f:
      line = line.lower()
      words = re.split(r'[^a-zA-Z]+', line)
   
      for w in words:
         if w:
            total += 1
   
            if w == word:
               count += 1

   searchObj = re.search(r'lyrics\/(.*)\.txt', file)
   artist = searchObj.group(1)
   artist = re.sub(r'[^a-zA-Z]', ' ', artist)

   n_matches[artist] = count
   n_words[artist] = total   

   f.close()

for key in sorted(n_words.keys()):
   print("%4d/%6d = %.9f %s" %(n_matches[key], n_words[key], 
                               n_matches[key]/n_words[key], key))
