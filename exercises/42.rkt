; Program moves image of CAR on the BACKGROUND from left to right with speed 3
; pixels per tick
;
; Exercise 42:
; modify program from exercise #41 so that a state denotes the
; x-coordinate of the right-most edge of the CAR instead of left
#lang htdp/bsl
(require 2htdp/universe)
(require 2htdp/image)
(require rackunit)

; World constants
; number is pixels
(define WIDTH-OF-WORLD 200)
(define HEIGHT-OF-WORLD (/ WIDTH-OF-WORLD 3))

; Graphical constants
; number is pixels
(define WHEEL-RADIUS 3)
(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
; distance from left to right wheel margins (not centers)
(define SPACE
  (rectangle WHEEL-DISTANCE 0 "solid" "white"))
(define WHEEL
  (circle WHEEL-RADIUS "solid" "black"))
(define BOTH-WHEELS
  (beside WHEEL SPACE WHEEL))
(define CAR-BASE
  (rectangle
   (* WHEEL-RADIUS 12)
   (* WHEEL-RADIUS 2)
   "solid" "gray"))
(define CAR-CABIN
  (rectangle
   (+ WHEEL-DISTANCE (* WHEEL-RADIUS 2))
   (* WHEEL-RADIUS 3)
   "solid" "gray"))
(define CAR
  (underlay/align/offset "middle" "bottom"
                  (underlay/align "middle" "bottom" CAR-CABIN CAR-BASE)
                  0
                  WHEEL-RADIUS
                  BOTH-WHEELS))
; position of CAR on y axis. expects usage with top anchor.
(define Y-CAR
   (- HEIGHT-OF-WORLD (image-height CAR)))
(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))
; position of TREE on x axis.
(define X-TREE (/ WIDTH-OF-WORLD 2))
; position of TREE on y axis. expects usage with top anchor.
(define Y-TREE (- HEIGHT-OF-WORLD (image-height TREE)))

(define SCENE (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))
; final scene
(define BACKGROUND (place-image/align TREE
                                      X-TREE
                                      Y-TREE
                                      "middle"
                                      "top"
                                      SCENE))
; Data definition
; A WorldState x is Number.
; Interpretation: x is the number of pixels between the left border of
; the scene and the car.

; Procedures
; Number -> WorldState
; launches the program from some initial state
; initial state is x pixels from the left margin
(define (main x)
  (big-bang x
            (on-tick tock)
            (to-draw render)
            (stop-when end?)))

; WorldState -> Image
; places the CAR x pixels from the left edge of the BACKGROUND and
; Y-CAR pixels from the top of the BACKGROUND. anchor of CAR is right
; top corner.
(define (render x)
  (place-image/align
   CAR
   x
   Y-CAR
   "right"
   "top"
   BACKGROUND))

; WorldState -> WorldState
; increments x by 3
; x represents number of pixels from left side of the BACKGROUND
; given: 0, expect: 3
; given 20, expect: 23
(define (tock x)
  (+ x 3))

; WorldState -> Boolean
; checks wether distance from left edge of BACKGROUND to left-most edge
; of CAR is bigger or equal to WIDTH-OF-WORLD
; given: 0, expect: true
; given: WIDTH-OF-WORLD, expect false
(define (end? x)
  (>= x (+ WIDTH-OF-WORLD (image-width CAR))))

; Unit tests
; render
(check-equal?
 (render 0)
 (place-image/align
  CAR
  0
  (- HEIGHT-OF-WORLD (image-height CAR))
  "right"
  "top"
  BACKGROUND)
 "render function returned unexpected image")

(check-equal?
 (render 50)
 (place-image/align
  CAR
  50
  (- HEIGHT-OF-WORLD (image-height CAR))
  "right"
  "top"
  BACKGROUND)
 "render function returned unexpected image")
