#lang htdp/bsl
(require 2htdp/image)

; world constants
(define WIDTH 100)
(define HEIGHT 200)
(define MTSCN (empty-scene WIDTH HEIGHT))
(define XCENTER (/ WIDTH 2))

; sea constants
(define SEA_LEVEL (* HEIGHT 0.3))
(define SEA (place-image/align
             (rectangle WIDTH SEA_LEVEL "solid" "blue")
             XCENTER HEIGHT "middle" "bottom"
             MTSCN))

; boat constants
(define BOAT_WIDTH (* WIDTH 0.4))
(define BOAT_HEIGHT (* HEIGHT 0.1))
(define BOAT_Y (- HEIGHT SEA_LEVEL))
(define BOAT (rectangle BOAT_WIDTH BOAT_HEIGHT "solid" "brown"))

; final image
(define RESULT (place-image
                BOAT
                XCENTER
                BOAT_Y
                SEA))
