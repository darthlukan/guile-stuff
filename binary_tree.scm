#!/usr/bin/guile -s
!#

(define (build-tree depth)
  (if (= depth 0)
    '(0)
    (list depth
          (build-tree (- depth 1))
          (build-tree (- depth 1)))))

(display 
  (format #f "~a\n" (build-tree 5)))
