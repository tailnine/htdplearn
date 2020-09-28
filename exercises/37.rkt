; Design the function string-rest, which produces a string like the given
; one with the first character removed.
#lang htdp/bsl

; String -> String
; Returns string without 1st character.
; given: "hello", expect: "ello"
(define (string-rest str) (substring str 1))
