;;; FILE: "st-blockClosure.scm"
;;; IMPLEMENTS: BlockClosure
;;; AUTHOR: Ken Dickey
;;; DATE: 16 July 2016

;; (requires 'st-core-classes)
;; (requires 'st-error-obj)

(define BlockClosure
  (newSubclassName:iVars:cVars:
   Object
   'BlockClosure '() '())
)

(addSelector:withMethod:
     BlockClosure
     'is:
     (lambda (self symbol)
       (or (eq? symbol 'BlockClosure)
           (superPerform:with: self 'is: symbol))))

(set! st-blockClosure-behavior
      (perform: BlockClosure 'methodDict))

(perform:with:
     BlockClosure
     'category:
     '|Kernel-Methods|)

(perform:with:
     BlockClosure
     'comment:
"I am a block closure -- a bit of code which remembers the environment in which I was created.
 I can be created, saved, stored in a variable, and used without being named."
)

(addSelector:withMethod: 
 	BlockClosure
        'selector
        (lambda (self)
          (let ( (selector (procedure-name self)) )
            ;; Scheme returns #false if unnamed.
            ;; Smalltalk returns nil in this case.
            (if selector
                selector
                st-nil))))

(addSelector:withMethod: 
 	BlockClosure
        'argumentCount
        (lambda (self) (procedure-arity self)))

(addSelector:withMethod:  ;; alias
 	BlockClosure
        'numArgs
        (lambda (self) (procedure-arity self)))


(addSelector:withMethod:  ;; alias
 	BlockClosure
        'value
        (lambda (self) (self)))

(addSelector:withMethod:  ;; alias
 	BlockClosure
        'value:
        (lambda (self arg1) (self arg1)))

(addSelector:withMethod:  ;; alias
 	BlockClosure
        'value:value:
        (lambda (self arg1 arg2)
          (self arg1 arg2)))

(addSelector:withMethod:  ;; alias
 	BlockClosure
        'value:value:value:
        (lambda (self arg1 arg2 arg3)
          (self arg1 arg2 arg3)))

(addSelector:withMethod:  ;; alias
 	BlockClosure
        'value:value:value:value:
        (lambda (self arg1 arg2 arg3 arg4)
          (self arg1 arg2 arg3 arg4)))

(addSelector:withMethod:  ;; alias
 	BlockClosure
        'valueWithArguments:
        (lambda (self args-array)
          (apply self (vector->list args-array))))

(addSelector:withMethod:
 	BlockClosure
        'whileFalse:
        (lambda (self thunk)
          (let loop ( (value (thunk)) )
            (if (st-false? value)
                (begin
                  (thunk)
                  (loop (self))
                value)))))

(addSelector:withMethod:
 	BlockClosure
        'whileTrue:
        (lambda (self thunk)
          (let loop ( (value (self)) )
            (if (st-true? value)
                (begin
                 (thunk)
                 (loop (self)))
                value))))

(addSelector:withMethod:
 	BlockClosure
        'whileFalse
        (lambda (self)
          (let loop ( (value (self)) )
            (if (st-false? value)
                (loop (self))
                value))))

(addSelector:withMethod:
 	BlockClosure
        'whileTrue
        (lambda (self)
          (let loop ( (value (self)) )
            (if (st-true? value)
                (loop (self))
                value))))

(addSelector:withMethod:
 	BlockClosure
        'whileNil
        (lambda (self)
          (let loop ( (value (self)) )
            (if (st-nil? value)
                (loop (self))
                value))))

(addSelector:withMethod:
 	BlockClosure
        'whileNotNil
        (lambda (self)
          (let loop ( (value (self)) )
            (if (st-nil? value)
                value
                (loop (self))))))

(addSelector:withMethod:
 	BlockClosure
        'ensure:
        (lambda (self afterThunk)
          (dynamic-wind
            (lambda () #false) ;; before
            self ; thunk
            afterThunk))) ;; after: always executed

;; NB: (Scm) raise is non-continuable and a caught exception
;;   will cause a "handler returned" exception.
;; Use (Scm) raise-continuable for on:to: to enable
;; the handler to return a value.

(addSelector:withMethod:
 	BlockClosure
        'on:do:
        (lambda (self exceptionClassOrSet handler)
          (with-exception-handler
             (lambda (anException)
               (if ($: exceptionClassOrSet 'handles: anException)
                   ;; valueWithPossibleArgument:
                   (if (= 1 (procedure-arity handler))
                       (handler anException)
                       (handler))
                   ;; re-raise if not handled here
                   ($ anException signal)) 
             )
             self)))


(addSelector:withMethod:
	BlockClosure
        'ifCurtailed:
        (lambda (self action)
          ;;  to class based system
          (let ( (curtailed? #true)
                 (result '()) )
            (dynamic-wind
              (lambda () #false) ;; before
              (lambda ()
                (set! result (self))
                (set! curtailed? #false))
              (lambda ()
                (if curtailed? (action))))
            result)
          ))
            

;;@@@



;; (provides st-blockClosure)

;;;			--- E O F ---			;;;
