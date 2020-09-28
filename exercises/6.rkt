#lang htdp/bsl
(require 2htdp/image)

(define CAT (bitmap "./images/cat.png"))
(define CAT_AREA (* (image-width CAT) (image-height CAT)))
