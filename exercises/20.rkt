#lang htdp/bsl
; Function removes char from string at ith position

(define (f str i) (string-append (substring str 0 i) (substring str (add1 i))))
