#!/usr/bin/guile -s
!#

(define balance 0)

(define get-balance
  (lambda ()
    balance))

(define deposit
  (lambda (amount)
    (set! balance (+ balance amount))
    balance))

(define withdraw
  (lambda (amount)
    (- balance amount)))

(display (get-balance))
(newline)

(display (deposit 1000))
(newline)

(display (get-balance))
(newline)

(display (withdraw 500))
(newline)

(display (get-balance))
(newline)
