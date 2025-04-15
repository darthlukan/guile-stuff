#!/usr/bin/guile \
-e main -s
!#

;;; my-collection is a list of integers from 1 to 10
(define my-collection '(1 2 3 4 5 6 7 8 9 10))

;;; find takes a search `term` and a `collection` as arguments
;;; and informs the user if `term` exists in `collection`
(define find
  (lambda (term collection)
    (if (pair? collection)
      (begin
        (display (format #f "Looking at ~a\n" (car collection)))
        (if (equal? (car collection) term)
          (begin
            (display (format #f "Found ~a!\n" term))
            #t)
          (find term (cdr collection)))
        #f))))

;;; main is a function serving is the entrypoint of the program.
(define main
  (lambda (args)
    (find 7 my-collection)
    (find 2 my-collection)))
