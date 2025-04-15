#!/usr/bin/guile \
-e main -s
!#

(define main
  (lambda ()
    (boolean? #t)              ; => #t
    (boolean? "Hello, World!") ; => #f
    (not #f)                   ; => #t
    (number? 42)               ; => #t
    (number? #t)               ; => #f
    (complex? 2+3i)            ; => #t
    (real? 2+3i)               ; => #f
    (rational? 3.1416)         ; => #t
    (integer? 42)              ; => #t
    (eqv? 42 42)               ; => #t
    (= 42 42)                  ; => #t, same as previous, but number specific
    (< 3 2)                    ; => #f
    (< 2 3)                    ; => #t
    (= 42 42.0)                ; => #t
    (+ 1 1)                    ; => 2
    (- 1 1)                    ; => 0
    (* 2 2)                    ; => 4
    (/ 2 2)                    ; => 1
    (expt 2 3)                 ; => 8
    (expt 4 1/2)               ; => 2.0
    (- 4)                      ; => -4, negation
    (/ 4)                      ; => 1/4, reciprocal
    (max 1 2 3 4 3 2 1)        ; => 4
    (min 1 2 3 4 3 2 1)        ; => 1
    (abs 1)                    ; => 1
    (abs -1)                   ; => 1
    (round 2.718)              ; => 3
    (ceiling 2.718)            ; => 3
    (floor 2.718)              ; => 2
    (eqv? 'Calorie 'calorie)   ; => #t, case-insensitive
    (string-ref "Hello" 0)     ; => #\H
    (define hello (string #\H #\e #\l #\l #\o)) ; => "Hello"
    (string-set! hello 1 #\a)  ; => "Hallo"
    (define y (list 1 2 3 4))  ; => (1 2 3 4)
    (list-ref y 0)             ; => 1
    (list-ref y 3)             ; => 4
    (list-tail y 1)            ; => (2 3 4)
    (list-tail y 3)            ; => (4)
    #|
    ; Standard if
    (if (test-expression)
        then-branch
        else-branch)
    ; Else-less if
    (if (test-expression)
        then-branch)

    (when (test-condition)
          (then))

    (unless (test-condition)
            (then))

    ; Nested if. First condition to pass returns, else we hit else
    (cond ((test-condition0) value)
          ((test-condition1) other-value)
          (else another-value))

    ; switch...case, minus the need for more words or "break"
    (case var
      ((condition0) val)
      ((condition1) val)
      (else val))
    |#
    (let ((x 1)
          (y 2)
          (z 3))
      (list x y z))              ; => (1 2 3)

    (let* ((x 1)
           (y x))
      (+ x y))                   ; => 2

    (define throw-one-die
      (lambda ()
        (let ((result (ceiling (* (random) 6))))
          result)))

    (define throw-two-dice
      (lambda ()
        (+ (throw-one-die) (throw-one-die))))

    (define factorial
      (lambda (n)
        (if (= n 0) 1
            (* n (factorial (- n 1))))))

    (define is-even?
      (lambda (n)
        (if (= n 0) #t
            (is-odd? (- n 1)))))

    (define is-odd?
      (lambda (n)
        (if (= n 0) #f
            (is-even? (- n 1)))))

    ; For recursive and mutually recursive local procedures
    ; letrec ensures the lexical variables and refer to
    ; themselves/each other in their initializations
    (letrec ((local-even? (lambda (n)
                            (if (= n 0) #t
                                (local-odd? (- n 1)))))
             (local-odd? (lambda (n)
                           (if (= n 0) #f
                               (local-even? (- n 1))))))
      (list (local-even? 23) (local-odd? 23)))

    ; Named let
    (let countdown ((i 10))
      (if (= i 0) 'liftoff
          (begin
            (display i)
            (newline)
            (countdown (- i 1)))))

    (map + '(1 2 3) '(10 20 30))               ; => (11 22 33)

    (define greeting-file (open-output-file "greeting.txt"))
    (display "hello" greeting-file)
    (write-char #\space greeting-file)
    (display 'world greeting-file)
    (close-output-port greeting-file)          ; => "hello world" is now in greeting.txt

    (call-with-input-file "greeting.txt"
      (lambda (i)
        (let* ((a (read-char i))
               (b (read-char i))
               (c (read-char i)))
          (list a b c))))                       ; => (#\h #\e #\l), greeting.txt is opened and then closed for us

    ; gensym makes unique symbols so our templates don't clobber
    ; other symbol names which may exist
    (define-macro my-or
      (lambda (x y)
        (let ((temp (gensym)))
          `(let ((,temp ,x))
             (if ,temp ,temp ,y)))))))
