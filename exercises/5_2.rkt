#lang htdp/bsl
(require 2htdp/image)

; world constants
(define WIDTH 100)
(define HEIGHT 200)
(define MTSCN (empty-scene WIDTH HEIGHT "blue"))
(define XCENTER (/ WIDTH 2))

; ground constants
(define GROUND_LEVEL (* HEIGHT 0.3))
(define GROUND (place-image/align
                (rectangle WIDTH GROUND_LEVEL "solid" "gray")
                XCENTER HEIGHT "middle" "bottom"
                MTSCN))

; tree constants
(define TREE_WIDTH (* WIDTH 0.2))
(define TREE_HEIGHT (* HEIGHT 0.4))
(define TREE_Y (- HEIGHT GROUND_LEVEL))

(define TREE (overlay/align/offset
              "middle"
              "bottom"
              (rectangle TREE_WIDTH (* TREE_HEIGHT 0.5)
                         "solid" "green")
              0
              (* TREE_HEIGHT 0.5)
              (rectangle (* TREE_WIDTH 0.5) (* TREE_HEIGHT 0.5)
                         "solid" "brown")))


; final image
(define RESULT (place-image/align
                TREE
                XCENTER
                TREE_Y
                "middle"
                "bottom"
                GROUND))
