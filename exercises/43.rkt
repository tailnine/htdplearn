; Program moves image of CAR on the BACKGROUND from left to right with
; SPEED using sine wave traectory.

; Exercise 43
; Modify program from exercise #42 so that:
; * the state denotes the number of clock ticks since the animation
; started;
; * CAR moves according to a sine wave;
;
; Additional files:
; - 43-sine.jpg - math function for sine wave traectory and it's brief
; explanation.
#lang htdp/bsl
(require 2htdp/universe)
(require 2htdp/image)
(require rackunit)

; World constants

(define WIDTH-OF-WORLD 600)
(define HEIGHT-OF-WORLD (/ WIDTH-OF-WORLD 3))


; Graphical constants

; number is pixels
(define WHEEL-RADIUS 3)

(define WHEEL-DISTANCE (* WHEEL-RADIUS 5))
; distance between wheel borders (not centers)
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

; pixels per clock tick
(define SPEED 2)

; coefficients for sine wave traectory
(define C-AMPLITUDE 2)
(define C-FREQUENCY 8)

(define TREE
  (underlay/xy (circle 10 "solid" "green")
               9 15
               (rectangle 2 20 "solid" "brown")))
; position of TREE on x-axis.
(define X-TREE (/ WIDTH-OF-WORLD 2))
; position of TREE on y-axis. expects usage with top anchor.
(define Y-TREE (- HEIGHT-OF-WORLD (image-height TREE)))

(define SCENE (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))
; final scene
(define BACKGROUND (place-image/align TREE
                                      X-TREE
                                      Y-TREE
                                      "middle"
                                      "top"
                                      SCENE))


; General data definition
; A WorldState t is Number.
; Interpretation: t is the number of clock ticks since the animation
; started.

; Procedures

; Signature: Number -> WorldState
; Data definition: WorldState t is Number which represents number of ticks
; passed since beginning.
; Purpose: launches program from some initial state.
(define (main t)
  (big-bang t
            (on-tick tock)
            (to-draw render)
            (stop-when end?)))

; Signature: WorldState -> Image
; Data definition:
; Purpose: places the car (distance t) pixels from the left edge and
; (y-car t) pixels from the top of the BACKGROUND. Anchor of CAR is right
; bottom corner.
(define (render t)
  (place-image/align
   CAR
   (distance t)
   (y-car t)
   "right"
   "bottom"
   BACKGROUND))

; Signature: WorldState -> Number
; Purpose: calculates distance passed by CAR with SPEED on x-axis in
; given number of clock ticks.
; Data definition: input number is clock ticks. Output is number of
; pixels from 0 point on x-axis to anchor point CAR.
; Examples (SPEED=1)
; given: 0, expected: 0
; given: 50, expected: 50
; Examples (SPEED=3)
; given: 0, expected: 0
; given: 50, expected: 150
(define (distance t) (* SPEED t))

; Signature: Number -> Number
; Purpose: computes position of CAR on y-axis by applying sine wave
; trigonometry function for current position of CAR on x-axis.
; Data definition: input number is distance (in pixels) from 0 on x-axis
; to anchor of CAR image. Output is position of CAR anchor point on
; y-axis.
; Comment: see 43-sine.jpg in exercises directory for math function
; and some brief explanation.
(define (y-car t)
  (+ (/ (* HEIGHT-OF-WORLD
           (+ (sin (+ (/ (distance t) C-FREQUENCY) (/ pi 2))) 1))
        (* 2 C-AMPLITUDE))
     (/ (- (* C-AMPLITUDE HEIGHT-OF-WORLD) HEIGHT-OF-WORLD)
        (- (sqr C-AMPLITUDE) C-AMPLITUDE))))


; Signature: WorldState -> WorldState
; Purpose: increments number of clock ticks by 1 on every clock tick.
; Data definition: WorldState is current number of clock ticks.
; Output is next number of clock ticks which become new WorldState.
(define (tock t) (add1 t))

; WorldState -> Boolean
; Purpose: checks wether distance from left edge of BACKGROUND to
; left-most edge of CAR is bigger or equal to WIDTH-OF-WORLD.
; given: 0, expect: true
; given: (+ WIDTH-OF-WORLD (image-width CAR)), expect: false
(define (end? t)
  (>= (distance t) (+ WIDTH-OF-WORLD (image-width CAR))))

; Unit tests
; render
