;;; FILE: "st-magnitude.scm"
;;; IMPLEMENTS: Magnitude abstract class
;;; AUTHOR: Ken Dickey
;;; DATE: 14 June 2016

;; (require 'st-core-classes)

(define Magnitude
  (newSubclassName:iVars:cVars:
   Object
   'Magnitude '() '())
)

(perform:with: Magnitude
               'comment:
"I'm the abstract class Magnitude that provides common protocol for objects that have
the ability to be compared along a linear dimension, such as dates or times.
Subclasses of Magnitude include Date, ArithmeticValue, and Time, as well as LookupKey.
 
 
My subclasses should implement
  < aMagnitude 
  = aMagnitude 
  hash

Here are some example of my protocol:
     3 > 4
     5 = 6
     100 max: 9
	7 between: 5 and: 10 
")

(perform:with:
     Magnitude
     'category: '|Kernel-Magnitude|)

(addSelector:withMethod:
     Magnitude
     'is:
     (lambda (self symbol)
       (or (eq? symbol 'Magnitude)
           (superPerform:with: self 'is: symbol))))

(for-each
   (lambda (selector)
       (addSelector:withMethod: 
        Magnitude
        selector
        (make-subclassResponsibility selector))) ; in st-object
   '( < > = <= >= hash between:and: min: max: min:max: )
)



;; (provide 'st-magnitude)

;;;			--- E O F ---			;;;
