#lang htdp/bsl
(require 2htdp/universe)
(require 2htdp/image)
(require rackunit)
; Design a big-bang program that simulates a traffic light for a given
; duration. The program renders the state of a traffic light as a solid
; circle of the appropriate color, and it changes state on every clock
; tick.

; Constants
(define WORLD-HEIGHT 100)
(define WORLD-WIDTH WORLD-HEIGHT)
(define SCENE (empty-scene WORLD-WIDTH WORLD-HEIGHT))
(define TRAFFIC-LIGHT-RADIUS (/ WORLD-HEIGHT 2))
(define X-POS (/ WORLD-HEIGHT 2))
(define Y-POS (/ WORLD-WIDTH 2))

; Functions

; main
; Data definition:
; WorldState is current TrafficLight.
; Signature:
; WorldState -> WorldState
; Purpose:
; Starts program from some initial state. Initial states can be:
; "red", "green", "yellow".

(define (main TrafficLight)
  (big-bang TrafficLight
            (on-tick traffic-light-next)
            (to-draw render)))


; traffic-light-next
; Data definition:
; Strings represent TrafficLight.TrafficLight is used for WorldState.
; TrafficLight can be: "red", "yellow", or "green".
; 
; Signature:
; WorldState -> WorldState
; 
; Purpose:
; Computes next TrafficLight using given TrafficLight.
;
; given: "red"
; expect: "green"
; given: "green"
; expect: "yellow"
; given: "yellow"
; expect: "green"

(define (traffic-light-next TrafficLight)
  (cond
    [(string=? "red" TrafficLight) "green"]
    [(string=? "green" TrafficLight) "yellow"]
    [(string=? "yellow" TrafficLight) "red"]))

; Signature:
; WorldState -> Image
; 
; Purpose:
; Draws image of TrafficLight on the SCENE
;
; given: "red"
; expected: (place-image/align (circle WORLD-WIDTH "solid" "green")
;                                      X-POS Y-POS "center" "center"
;                                      SCENE)
; given: "green"
; expected: (place-image/align (circle WORLD-WIDTH "solid" "yellow")
;                                      X-POS Y-POS "center" "center"
;                                      SCENE)
; given: "yellow"
; expected: (place-image/align (circle WORLD-WIDTH "solid" "red")
;                                      X-POS Y-POS "center" "center"
;                                      SCENE)
(define (render TrafficLight)
  (place-image/align (circle TRAFFIC-LIGHT-RADIUS "solid" TrafficLight)
                     X-POS Y-POS "center" "center"
                     SCENE))

