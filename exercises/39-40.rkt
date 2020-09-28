; Program moves image of CAR on the SCENE from left to right with speed 3
; pixels per tick
;
; Exercises 39, 40:
; Model CAR with single point of control based on WHEEL-RADIUS;
; Develop clock tich handling procedure;
; Develop render function;
; Develop examples and unit tests for render procedure.
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
; position of CAR on y axis. expects usage with left top anchor.
(define Y-CAR
   (- HEIGHT-OF-WORLD (image-height CAR)))

(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))

; Procedures
; Number -> WorldState
; launches the program from some initial state
; initial state is x pixels from the left margin
(define (main x)
  (big-bang x
            (on-tick tock)
            (to-draw render)))

; WorldState -> Image
; places the left margin of the CAR x pixels from
; the left margin of the BACKGROUND image and Y-CAR pixels
; from the top. anchor of CAR is left top corner.
(define (render x)
  (place-image/align
   CAR
   x
   Y-CAR
   "left"
   "top"
   BACKGROUND))

; WorldState -> WorldState
; increments x by 3 per tick to move the car right
; given: 0, expect: 3
; given 20, expect: 23
(define (tock x)
  (+ x 3))

; Unit tests
; render
(check-equal?
 (render 0)
 (place-image/align
  CAR
  0
  (- HEIGHT-OF-WORLD (image-height CAR))
  "left"
  "top"
  BACKGROUND)
 "render function returned unexpected image")

(check-equal?
 (render 50)
 (place-image/align
  CAR
  50
  (- HEIGHT-OF-WORLD (image-height CAR))
  "left"
  "top"
  BACKGROUND)
 "render function returned unexpected image")
