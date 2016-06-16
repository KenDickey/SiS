# SiS

## Smalltalk in Scheme -- clean room bootstrap of Smalltalk kernel in R7RS Larceny Scheme

Basically an exercise in deeply understanding Smalltalk.

I like to build an executable model to get the semantics down properly.

Doing so in a different language with a well understood semantics is a good exercise.  It allows one to concentrate on language differences.

This is very much a work in progress.

## Basics:
  - Message send 
    - Object behaviors are dictionaries/hash-tables
  - Leverage Scheme runtime
    - Scheme numbers, strings, characters, vectors/arrays, bytevectors ..
    - Closures, GC, exceptions, finalization
    - Dynamic compilation to native machine code
  - Keep things as simple as possible
    - Comprehension over speed, but don't be odiously dumb

## Open Questions/Problems:
  - Can Larceny Scheme's *Environments* be leveraged to provide cleanly separated Scheme and Smalltalk namespaces?
  - #thisContext: How to introduce decent debugging?
  - What kinds of caching would make significant performance difference?
      - Symbol property-list
      - PIC at call sites
      - Hashtable cache
  - Finalization pecularities (expectation of early finalization)
  - How best to make Smalltalk object structures native to Larceny?
  - What compiler/runtime changes would help?
  - #allInstancesDo:
  - #become:
  - Dynamic class changes & schema evolution (w lazy instance update)

## The story so far..
  1. Dispatch mechanics (message send with #perform:)
  2. Class Structure (bootstrap + fixup; classes can create subclasses)
  3. Basic unit tests (need to be populated)

## Upcoming
  - Fill in the class structure (approx ANSI)
  - Parsing Smalltalk with location/position info
  - Transliteration into Scheme
  - Read and execute Smalltalk code directly
  - Look at runtime issues
  - _Bootstrap Morphic_
    


