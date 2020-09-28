#lang htdp/bsl
(require 2htdp/image)
(require 2htdp/universe)
(require rackunit)

; Exercise 47.
; Tasks:
; * design a world program that maintains and displays a "happiness gauge";
; * program should consume the maximum level of happiness [1];
; * the gauge display should start with the maximum score [2];
; * with each clock tick happiness should decrease by -0.1;
; * happiness can't fall below minimal happiness score;
; * minimal happiness score is 0;
; * when "down arrow" key is pressed happiness should be decreased by 1/5;
; * when "up arrow" key is pressed happiness should be increased by 1/3;
; * happiness display should be a scene with a solid red rectangle with a
; black frame;
; * when happiness level is 0, the red bar should be gone;
; * whem happiness level is 100, the bar should go all the way across
; the scene.

;  Tasks revision:
;  * [1] program should consume current level of happiness because maximum
;  level of happiness can't be interpreted as the state of the program. Maximum
;  happiness can be defined as constant.
;  * [2] the gauge display should start from some initial state which becomes
;  the current world state;
;  * happiness can't be raised above maximum level.

; Constants
; World constants
(define HAPPINESS-MIN 0)
(define HAPPINESS-MAX 100)
(define HAPPINESS-CLOCK-STEP 0.1)
(define HAPPINESS-UP-KEY-STEP 1/3)
(define HAPPINESS-DOWN-KEY-STEP 1/5)

; Graphical constants
(define WORLD-WIDTH 200)
(define BACKGROUND (empty-scene WORLD-WIDTH HAPPINESS-MAX))


; General data definition.
; WorldState (h) is Number.
; Interpretation: WorldState (h) represents the current happiness level.
; Notes: happiness level can't fall below HAPPINESS-MIN and can't be raised
; above HAPPINESS-MAX.

; Functions
; Signature: Number -> WorldState
; Data definition: input is any number in range from HAPPINESS-MIN to
; HAPPINESS-MAX. Output is initial WorldState.
; Purpose: main world function, launches program from some initial state.
(define (gauge-prog h)
  (big-bang h
            (on-tick tock)
            (on-key keyhandler)
            (to-draw render)))

; (tock h)
; Signature: WorldState -> WorldState
; Data definition: input is current WorldState. Output is Number which becomes
; next WorldState.
; Purpose: clock tick handler. If current happiness level is bigger than
; HAPPINESS-MIN then decrements it by HAPPINESS-CLOCK-STEP, returns
; HAPPINESS-MIN otherwise.
; Examples:
; given: 50 , expected: (- 50 HAPPINESS-CLOCK-STEP)
; given: 0 , expected: 0
; given: -50 , expected: 0
(define (tock h)
  (cond
    ((> h HAPPINESS-MIN) (- h HAPPINESS-CLOCK-STEP))
    (else HAPPINESS-MIN)))

; (keyhandler h)
; Signature: WorldState KeyEvent -> WorldState
; Data definition: inputs are current WorldState and KeyEvent (String). Output
; is Number which becomes next WorldState.
; Purpose: key event handler. If KeyEvent is up arrow key and current happiness
; level is smaller than HAPPINESS-MAX then increases happiness by
; HAPPINESS-UP-KEY-STEP. If KeyEvent is down arrow key and current happiness
; level is smaller than HAPPINESS-MIN then decreases happiness by
; HAPPINESS-DOWN-KEY-STEP. Returns current happiness otherwise.
;
(define (keyhandler h key)
  (cond
    ((and (key=? key "up") (< h HAPPINESS-MAX)) (+ h HAPPINESS-UP-KEY-STEP))
    ((and (key=? key "down") (> h HAPPINESS-MIN)) (- h HAPPINESS-DOWN-KEY-STEP))
    (else h)))

; (render h)
; Signature: WorldState -> Image
; Data definition: input is current WorldState. Output is Image of happiness
; meter rendered on BACKGOUND or just BACKGROUND when h <= 0.
; Purpose: If happiness level is bigger than 0 than renders current happiness
; meter on BACKGROUND, renders BACKGROUND otherwise.
(define (render h)
  (cond
    ((> h 3)
     (overlay/align
      "middle" "bottom"
      (place-image/align
       (rectangle (- WORLD-WIDTH 2) (- h 2) "solid" "red")
       1 1 "left" "top"
       (rectangle WORLD-WIDTH h "solid" "black"))
      BACKGROUND))
    ((and (> h 0) (< h 3))
     (overlay/align
      "middle" "bottom"
      (rectangle WORLD-WIDTH h "solid" "black")
      BACKGROUND))
    (else BACKGROUND)))

; Unit tests
; (tock h)
; FIXME doesn't work for some reason. Works if constant replaced with float
; like 0.1 inside test and tock body.
(check-eq? (tock 50) (- 50 HAPPINESS-CLOCK-STEP))
(check-eq? (tock 0) 0)
(check-eq? (tock -50) 0)
