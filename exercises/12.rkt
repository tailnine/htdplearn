#lang htdp/bsl
; Function for computing equilateral cube's volume and surface
; by given length of it's side

; volume
(define (f x) (expt x 3))

; surface
(define (g x) (sqr x))
