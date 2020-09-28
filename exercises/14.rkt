#lang htdp/bsl
; Function for extracting last 1string from non-empty string

(define (f x) (string-ith x (- (string-length x) 1)))
