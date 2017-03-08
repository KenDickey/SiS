;;; IMPLEMENTS: Unit tests for st-conditions.scm
;;; AUTHOR: Ken Dickey
;;; DATE: 16 January 2017

;; (require 'st-conditions)

(define zero-divide #f)
(define frob-error  #f)

(define-syntax capture-condition ;; to explore
  (syntax-rules ()
    ((capture-condition form)
     (call/cc
      (lambda (exit)
        (with-exception-handler
         (lambda (c) (exit c))
         (lambda ()  form)))))))


(define (setup-st-conditions)
  (set! zero-divide
        (capture-condition (/ 3 0)))
  (set! frob-error
        (capture-condition
         (error "frob" 'a "bee" $c 47)))
)

(define (cleanup-st-conditions)
  (set! zero-divide #f)
  (set! frob-error  #f)
)

(add-test-suite 'st-conditions
                setup-st-conditions
                cleanup-st-conditions)

(add-equal-test 'st-conditions
 #((isMessage . #t)
   (message . "/: zero divisor: 3 0 \n")
   (isWho . #t)
   (isAssertion . #t)
   (who . "/"))
 (let-values ( ((keys-vec vals-vec)
                 (hashtable-entries
                  (condition->dictionary
                     zero-divide)))
             )
   (vector-map cons keys-vec vals-vec))
 "zero-divide exception asDictionary")

;; (ensure-exception-raised 'st-conditions
;;    (make-error-string-predicate   "Failed message send: #glerph to ")
;;    (perform: %%test-object 'glerph)
;;    "obj glerph -> doesNotUnderstand")


;;;			--- E O F ---			;;;
