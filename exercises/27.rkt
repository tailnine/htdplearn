#lang htdp/bsl
; Remove magical numbers from program (movie theater profit calculator)
#|
(define (attendees ticket-price) 
  (- 120 (* (- ticket-price 5.0) (/ 15 0.1))))

(define (revenue ticket-price) 
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price) 
  (+ 180 (* 0.04 (attendees ticket-price))))

(define (profit ticket-price) 
  (- (revenue ticket-price) 
     (cost ticket-price)))
|#

; constants
(define ATTENDANCE_PRICE_5 120)
(define PRICE_ATTENDANCE_120 5.0)
(define ATTENDANCE_CHANGE 15)
(define CHANGE_THRESHOLD 0.1)
(define FIXED_COST 180)
(define ATTENDEE_COST 0.04)

; helper functions
(define (attendees ticket-price) 
  (- ATTENDANCE_PRICE_5 (* (- ticket-price PRICE_ATTENDANCE_120)
                           (/ ATTENDANCE_CHANGE CHANGE_THRESHOLD))))

(define (revenue ticket-price) 
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price) 
  (+ FIXED_COST (* ATTENDEE_COST (attendees ticket-price))))

; main function
(define (profit ticket-price) 
  (- (revenue ticket-price) 
     (cost ticket-price)))
