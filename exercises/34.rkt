; Design the function string-first, which extracts the first character from a non-empty string.
; Don’t worry about empty strings.
#lang htdp/bsl

; String -> 1String
; Returns 1st character of a string.
; given: "hello", expect: "h"
(define (string-first str) (string-ith str 0))
