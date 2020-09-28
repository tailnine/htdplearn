#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)

; Program continuosly moves image from left to right from it's starting position
; with SPEED of 3 pixels per clock tick. Whenever image disappears on the right,
; it reappears on the left. Program chooses between CAT and CAT2 for image
; based on wether the x-coordinate is odd.

; Exercise 46.
; Tasks:
; * adjust rendering function from exercise #45 so that it uses one cat image
; or the other based on whether the x-coordinate is odd.

; World constants
(define WIDTH-OF-WORLD 600)
(define HEIGHT-OF-WORLD (/ WIDTH-OF-WORLD 3))
(define SPEED 3)

; Graphical constants
(define CAT (bitmap "images/cat.png"))
(define CAT2 (bitmap "images/cat2.png"))
(define BACKGROUND (empty-scene WIDTH-OF-WORLD HEIGHT-OF-WORLD))

; General data definition
; WorldState (x) is Number.
; Interpretation: x is position of cat's image anchor on x-axis of BACKGROUND.

; Notes
; Anchor of cat's image is bottom-middle point.

; Functions
; Signature: Number -> WorldState
; Data definition: WorldState is position of cat's image anchor on x-axis of
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
; Purpose: calculates next position of cat's image anchor on x-axis using
; SPEED. If leftmost point of cat's image on x-axis is less than WIDTH-OF-WORLD
; then add SPEED to current position, otherwise return difference of 0 and
; half of current cat's image width. (which-cat x) chooses between cat images.
; See 45-explanation.jpg in the exercises directory for visual explanation.
(define (tock x)
  (cond
    ((< (cat-left-point x) WIDTH-OF-WORLD)
     (+ x SPEED))
    ((>= (cat-left-point x) WIDTH-OF-WORLD)
     (- 0 (/ (image-width (which-cat x)) 2)))))

; Signature: WorldState -> Number
; Data definition: input is current WorldState. Output is current
; position of leftmost point of CAT on x-axis.
; Purpose: calculates position of leftmost point of CAT on x-axis.
(define (cat-left-point x)
  (- x (/ (image-width (which-cat x)) 2)))

; Signature: WorldState -> Image
; Data definition: input is current WorldState. Output is image CAT or CAT2.
; Purpose: chooses between 2 images of cat depending on x. If x is odd it
; returns CAT, CAT2 otherwise.
(define (which-cat x)
  (cond
    ((odd? (floor x)) CAT)
    (else CAT2)))

; Signature: WorldState -> Image
; Data definition: input is current WorldState. Output is CAT or CAT2 on
; BACKGROUND.
; Purpose: renders CAT or CAT2 on BACKGROUND using current WorldState.
; (which-cat x) chooses between cats.
; Notes: uses middle bottom point for CAT's anchor
(define (render x)
  (place-image/align
   (which-cat x)
   x
   HEIGHT-OF-WORLD
   "middle"
   "bottom"
   BACKGROUND))
