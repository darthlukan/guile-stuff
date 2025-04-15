#!/usr/bin/guile -s
!#


;; Hello Word!
(display "Hello, World!") (newline)

;; Loops don't actually exist, but recursion does!
;; Calc factorial example
(define factorial                                 ;function name
  (lambda (n)                                     ;initial closure
    (define internal                              ;internal var
      (lambda (x current)                         ;function that actually performs work
        (if (= x 0)                               ;base case
          current                                 ;return for base case
          (internal (- x 1) (* x current)))))     ;else recurse
    (internal n 1)))                              ;initial call

(display (factorial 5))                           ; => 120
(newline)


;; "for element in list"
(define exists-in?
  (lambda (i l)
    (cond ((null? l) #f)
          ((equal? i (car l)) #t)
          (else (exists-in? i (cdr l))))))

(define z (list "one" "two" "three"))

(display (exists-in? "four" z))                   ; => #f
(newline)
(display (exists-in? "two" z))                    ; => #t
(newline)


;; Multiply by recursion
(define multiply
  (lambda (a b)
    (cond ((equal? b 1) a)
          (else (+ a (multiply a (- b 1)))))))

(display (multiply 5 5)) (newline)                ; => 25


;; Compare with eq?, eqv?, and equal?
(define comparisons
  (lambda (x y)
    (cond ((eq? x y) (display "same object") #t)
          ((eqv? x y) (display "same value") #t)
          ((equal? x y) (display "same") #t)
          (else ((display "not at all the same") #f)))))

(display (comparisons 1 1)) (newline)             ; => same object => #t
(display (comparisons 1 '(1))) (newline)          ; => not at all the same => #f

;; Object properties
(define obj
  (lambda (o prop val)
    (set-object-property! o prop val)))

(define my-object "Person") ; Make an object
(obj my-object "Name" "Brian") ; set property using our obj function (mimics set-object-property! built-in procedure)
(obj my-object "Age" 32)
(obj my-object "Gender" "Male")

(display my-object)(newline)                     ; => Person
(display (object-properties my-object))(newline) ; => ((Gender . Male) (Age . 32) (Name . Brian))
(display (object? my-object))(newline)


;; Hash tables
(define h (make-hash-table))
(hash-create-handle! h 'name "Brian")            ; Create (key . value)
(hash-create-handle! h 'age 32)
(hash-create-handle! h 'os "GNU/Linux")
(hash-count (const #t) h)                        ; => 3
(hash-get-handle h 'name)                        ; => (name . "Brian")  [Pair]
;; Access the value at key 'name
(cdr (hash-get-handle h 'name))                  ; => "Brian"
(hash-get-handle h 'occupation)                  ; => #f [Safe, hash-get-handle returns #f if the key is not there, Pair otherwise]
(hash-create-handle! h 'single #f)               ; => (single . #f)
(hash-get-handle h 'single)                      ; => (single . #f)
(hash-remove! h 'age)                            ; => #f
(hash-get-handle h 'age)                         ; => #f
(hash-remove! h 'single)                         ; => #f
(hash-count (const #t) h)                        ; => 2
