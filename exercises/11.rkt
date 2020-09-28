#lang htdp/bsl
; Function for computing distance from cartesian point (x,y) to the origin (0,0)

(define (f x y) (sqrt (+ (sqr x) (sqr y))))
