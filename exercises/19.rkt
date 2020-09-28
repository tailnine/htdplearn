#lang htdp/bsl
; Function consumes string and number i and inserts char "_" at ith position

(define (f str i) (string-append (substring str 0 i) "_" (substring str i)))
