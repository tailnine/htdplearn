#lang htdp/bsl
(require 2htdp/image)
; Function computes image area

(define (f image) (* (image-width image) (image-height image)))
