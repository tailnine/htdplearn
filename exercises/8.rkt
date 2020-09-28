#lang htdp/bsl
(require 2htdp/image)

(define IMAGE (bitmap "./images/cat.png"))

(define RESULT
  (if (< (image-width IMAGE) (image-height IMAGE))
      "tall"
      (if (> (image-width IMAGE) (image-height IMAGE))
          "wide"
          "square")))
