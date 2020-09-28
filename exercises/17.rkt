#lang htdp/bsl
(require 2htdp/image)
; Function computes if image tall, wide or square

(define (f image)
  (if (> (image-width image) (image-height image))
      "wide" (if (> (image-height image) (image-width image))
                 "tall" "square")))
