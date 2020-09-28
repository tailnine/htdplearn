#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

; Program continuosly moves CAT from left to right from it's starting position
; with SPEED of 3 pixels per clock tick. Whenever CAT disappears on the right,
; it reappears on the left.

; Exercise 45.
; Tasks:
; * desing world program that continuously moves the cat from left to right;
; * world program should consume the starting position of the cat;
; * make the cat move three pixels per clock tick;
; * whenever the cat disappears to the right, it reappears on the left.

; World constants
(define WIDTH-OF-WORLD 600)
(define HEIGHT-OF-WORLD (/ WIDTH-OF-WORLD 3))
(define SPEED 3)

; Graphical constants
(define CAT (bitmap "images/cat.png"))
(define WIDTH-OF-CAT (image-width CAT))
(define HEIGHT-OF-CAT (image-height CAT))
(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))

; General data definition
; WorldState (x) is Number.
; Interpretation: x is position of CAT's anchor on x-axis of BACKGROUND.

; Notes
; Anchor of CAT is bottom-middle point.

; Functions
; Signature: Number -> WorldState
; Data definition: WorldState is position of CAT's anchor on x-axis of
; BACKGROUND.
; Purpose: main world function. Launches program from some initial state.
(define (cat-prog x)
  (big-bang x
            (on-tick tock)
            (to-draw render)))

; (tock x)
; Signature: WorldState -> WorldState
; Data definition: input is current WorldState. Output is next
; WorldState.
; Purpose: calculates next position of CAT's anchor on x-axis using
; SPEED. If leftmost point of CAT on x-axis is less than WIDTH-OF-WORLD
; then add SPEED to current position, otherwise return difference of 0 and
; half of WIDTH-OF-CAT. See 45-explanation.jpg in the exercises
; directory for visual explanation.
(define (tock x)
  (cond ((< (cat-left-point x) WIDTH-OF-WORLD) (+ x SPEED))
        ((>= (cat-left-point x) WIDTH-OF-WORLD) (- 0 (/ WIDTH-OF-CAT 2)))))

; Signature: WorldState -> Number
; Data definition: input is current WorldState. Output is current
; position of leftmost point of CAT on x-axis.
; Purpose: calculates position of leftmost point of CAT on x-axis.
(define (cat-left-point x)
  (- x (/ WIDTH-OF-CAT 2)))

; (render x)
; Signature: WorldState -> Image
; Data definition: input is current WorldState. Output is CAT on
; BACKGROUND.
; Purpose: renders CAT on BACKGROUND using current WorldState.
; Notes: uses middle bottom point for CAT's anchor
(define (render x)
  (place-image/align CAT
                     x
                     HEIGHT-OF-WORLD
                     "middle"
                     "bottom"
                     BACKGROUND))
