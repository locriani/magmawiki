#!/usr/bin/env python
from sys import argv
import json
from difflib import SequenceMatcher

def help():
  print "----------------------------------"
  print "         An diff tool!"  
  print "----------------------------------"
  print
  print "Usage: file_a file_b"
  print "Output: JSON"
  print
  print "Example input:"
  print "  file_a: well, hello"
  print "  file_b: hullo there"
  print
  print """Example output:
  
    [
      {
        "type": "delete",
        "a": { "start": 0, "end": 6 },
        "b": { "start": 0, "end": 0 }
      },
      
      {
        "type": "replace",
        "a": { "start": 7, "end": 8 },
        "b": { "start": 1, "end": 2 }
      },
      
      {
        "type": "insert",
        "a": { "start": 11, "end": 11 },
        "b": { "start": 5, "end": 11 }
      }
    ]
    
    
(note: "first...last" excludes the last chatacter
   eg: the last character is at "last"-1)"""
  print
  
if __name__ == "__main__":
  
  if len(argv) != 3:
    help()
    exit(1)
    
  else:
    file_a, file_b = argv[1:]
    
    a = open(file_a).read()
    b = open(file_b).read()
    
    s = SequenceMatcher(None, a, b)
    
    result = []
    
    for type, a1, a2, b1, b2 in s.get_opcodes():
      if type != 'equal':
        result.append( { 
          'type': type,
          'a': {'start': a1, 'end': a2}, #'text': a[a1:a2]},
          'b': {'start': b1, 'end': b2}, #'text': b[b1:b2]},
        } )
    
    print json.dumps(result)
  