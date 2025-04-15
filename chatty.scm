#!/usr/bin/guile -s
!#

(define (chatty-add chatty-name . nums)
  (format #t "<~a> If you add those together you get ~a!\n"
          chatty-name (apply + nums)))

(chatty-add "Chester" 2 4 8 6)
