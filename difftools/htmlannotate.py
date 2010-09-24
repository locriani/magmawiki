#!/usr/bin/env python
from sys import argv
from lxml.html.diff import html_annotate

def help():
  print "----------------------------------"
  print "       An annotation tool!"  
  print "----------------------------------"
  print
  print "Usage: file_a:author1 file_b:author2 file_c:author3"
  print "Output: HTML"
  print
  print """Example output:
    <p><span title="author1">Here is</span>
    <b><span title="author2">a</span>" 
    <span title="author3">little</span></b>
    <i><span title="author2">text</span></i>
    <span title="author2">.</span></p>"""
  print
  

if __name__ == "__main__":
  
  if len(argv) < 3:
    help()
    exit(1)
    
  else:
    argpairs = [ arg.split(":") for arg in argv[1:] ]
    
    params = [ ( open(filename).read(), label ) for filename, label in argpairs ]
    
    print html_annotate(params)
