#lang htdp/bsl
(require 2htdp/image)

; Image -> Number
; Number represents px^2.
; Returns area of given image.
; given: (rectangle 5 10 "solid" "red"), expect: 50
(define (image-area img)
  (* (image-width img) (image-height img)))
