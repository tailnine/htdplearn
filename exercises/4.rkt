#lang htdp/bsl

(define STRING "helloworld")
(define i 5)

(define PREFIX1 (substring STRING 0 5))
(define SUFFIX1 (substring STRING i))
(define RESULT1 (string-append PREFIX1 "_" SUFFIX1))

(define PREFIX2 (substring RESULT1 0 i))
(define SUFFIX2 (substring RESULT1 (+ i 1)))
(define RESULT2 (string-append PREFIX2 SUFFIX2))
