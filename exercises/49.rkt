#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)
(require rackunit)

; Exercise 47.
; Reformulate program from figure 20 to use a nested expression.
; Figure:
; https://htdp.org/2020-5-6/Book/part_one.html#%28counter._%28figure._fig~3av5-from-prologue%29%29

(define WIDTH 100)
(define HEIGHT 60)
(define MTSCN (empty-scene WIDTH HEIGHT))
(define ROCKET (bitmap/file "../images/rocket.png"))
(define ROCKET-CENTER-TO-TOP
  (- HEIGHT (/ (image-height ROCKET) 2)))

(define (create-rocket-scene.v5 h)
  (place-image ROCKET
               50
               (cond [(<= h ROCKET-CENTER-TO-TOP) h]
                     [(> h ROCKET-CENTER-TO-TOP) ROCKET-CENTER-TO-TOP])
               MTSCN))
