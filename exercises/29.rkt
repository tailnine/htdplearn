#lang htdp/bsl
; Change logic of the program from exercise 27.
; Remove fixed cost, change cost per attendee ($1.50)

; constants
(define ATTENDANCE_PRICE_5 120)
(define PRICE_ATTENDANCE_120 5.0)
(define ATTENDANCE_CHANGE 15)
(define CHANGE_THRESHOLD 0.1)
(define ATTENDEE_COST 1.50)

; helper functions
(define (attendees ticket-price) 
  (- ATTENDANCE_PRICE_5 (* (- ticket-price PRICE_ATTENDANCE_120)
                           (/ ATTENDANCE_CHANGE CHANGE_THRESHOLD))))

(define (revenue ticket-price) 
  (* ticket-price (attendees ticket-price)))

(define (cost ticket-price) 
  (* ATTENDEE_COST (attendees ticket-price)))

; main function
(define (profit ticket-price) 
  (- (revenue ticket-price) 
     (cost ticket-price)))
