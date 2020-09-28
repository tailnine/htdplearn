; Design the function string-last, which extracts the last character from a non-empty string.
#lang htdp/bsl

; String -> 1String
; Extracts last character from the given string
; given: "hello", expect: "o"
(define (string-last str)
  (string-ith str (- (string-length str) 1)))
