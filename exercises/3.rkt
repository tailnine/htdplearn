#lang htdp/bsl

(define STRING "helloworld")
(define i 5)

(define PREFIX (substring STRING 0 5))
(define SUFFIX (substring STRING i))
(define RESULT (string-append PREFIX "_" SUFFIX))
