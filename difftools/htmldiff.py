#!/usr/bin/env python
from sys import argv
from lxml.html.diff import htmldiff

def help():
  print "----------------------------------"
  print "          An diff tool!"  
  print "----------------------------------"
  print
  print "Usage: <file_a> <file_b>"
  print "Output: HTML"
  print
  print "Example output:"
  print "    <ins>hello</ins><del>goodbye cruel</del> world"
  print
  

if __name__ == "__main__":
  
  if len(argv) != 3:
    help()
    exit(1)
    
  else:
    file_a, file_b = argv[1:]
    
    a = open(file_a).read()
    b = open(file_b).read()
    
    print htmldiff(a, b)
