; Program moves image of CAR on the BACKGROUND from left to right with
; SPEED using sine wave traectory. If the mouse is clicked on the canvas,
; the CAR is placed at the x-coordinate of that click.

; Exercise 44
; Modify program from exercise #43 so that:
; * CAR is placed on x-coordinate of mouse click on the canvas.
; Create unit tests for mouse click function using it's examples.
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
            (on-mouse hyper)
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

; Signature: WorldState Number Number String -> WorldState
; Data definition: inputs are current world state (number of ticks passed),
; x-coordinate of mouse event, y-coordinate of mouse event and name of mouse
; event (me). Output is new WorldState.
; Purpose: calculates how many ticks had to pass for the CAR to be in the
; x-coordinate of the mouse click event.
; Note: we can't return the x-coordinate of the click mouse event because in
; exercise #42 program was modified so that WorldState interprets as number
; of ticks since the animation started.
; Examples:
; given: 21 10 20 "enter"
; wanted: 21
; given: 42 10 20 "button-down"
; wanted (t-of-x 42)
; given: 42 10 20 "move"
; wanted: 42
(define (hyper t x-mouse y-mouse me)
  (cond
    ((string=? "button-down" me) (t-of-x x-mouse))
    (else t)))

; Signature: Number -> Number
; Data definition: input is x-coordinate. Output is number of clock ticks.
; Purpose: Calculates how many ticks had to pass for the point with SPEED
; to be in the x-coordinate.
; Examples:
; given: 50
; wanted: (/ 50 SPEED)
(define (t-of-x x)
  (/ x SPEED))

; Signature: WorldState -> Boolean
; Purpose: checks wether distance from left edge of BACKGROUND to
; left-most edge of CAR is bigger or equal to WIDTH-OF-WORLD.
; given: 0, expect: true
; given: (+ WIDTH-OF-WORLD (image-width CAR)), expect: false
(define (end? t)
  (>= (distance t) (+ WIDTH-OF-WORLD (image-width CAR))))

; Unit tests
; hyper
(check-eq?
 (hyper 21 10 20 "enter") 21)

(check-eq?
 (hyper 42 10 20 "button-down") (t-of-x 10))

(check-eq?
 (hyper 42 10 20 "move") 42)

; t-of-x
(check-eq?
 (t-of-x 50) (/ 50 SPEED))
