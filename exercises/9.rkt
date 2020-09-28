#lang htdp/bsl
(require 2htdp/image)

(define IN (sqrt -1))
(define IMAGE-AREA (if (image? IN) (* (image-width IN) (image-height IN)) IN))

(define RESULT
  (if (string? IN) (string-length IN)
      (if (image? IN) IMAGE-AREA
          (if (and (number? IN) (real? IN)) (if (> IN 0) (sub1 IN) IN)
              (if (boolean? IN) (if IN 10 20)
                  "ERROR: UNEXPECTED DATA TYPE")))))

RESULT
