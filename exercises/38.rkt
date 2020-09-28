; Design the function string-remove-last, which produces a string like the
; given one with the last character removed.
#lang htdp/bsl

; String -> String
; Returns string without last character.
; given: "hello", expect: "hell"
(define (string-remove-last str)
  (substring str 0 (- (string-length str) 1)))
