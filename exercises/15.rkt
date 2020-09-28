#lang htdp/bsl
; Function computes implication with 2 arguments.
; #true if sunny is #false or friday is #true (sunny => friday).

(define (f sunny friday) (or (not sunny) friday))
