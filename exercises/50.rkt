#lang htdp/bsl
(require rackunit)

; Add tests to cover all cases to the given program

; TrafficLight -> TrafficLight

(define (traffic-light-next s)
  (cond
    [(string=? "red" s) "green"]
    [(string=? "green" s) "yellow"]
    [(string=? "yellow" s) "red"]))

; Tests
(check-eq? (traffic-light-next "red") "green")
(check-eq? (traffic-light-next "green") "yellow")
(check-eq? (traffic-light-next "yellow") "red")
