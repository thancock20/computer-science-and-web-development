;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-beginner-abbr-reader.ss" "lang")((modname 61-space-invaders) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/universe)
(require 2htdp/image)

;; Space Invaders


;; Constants:

(define WIDTH  300)
(define HEIGHT 500)

(define INVADER-X-SPEED 1.5)  ;speeds (not velocities) in pixels per tick
(define INVADER-Y-SPEED 1.5)
(define TANK-SPEED 2)
(define MISSILE-SPEED 10)

(define HIT-RANGE 10)

(define INVADE-RATE 100)

(define BACKGROUND (empty-scene WIDTH HEIGHT))

(define INVADER
  (overlay/xy (ellipse 10 15 "outline" "blue")              ;cockpit cover
              -5 6
              (ellipse 20 10 "solid"   "blue")))            ;saucer

(define TANK
  (overlay/xy (overlay (ellipse 28 8 "solid" "black")       ;tread center
                       (ellipse 30 10 "solid" "green"))     ;tread outline
              5 -14
              (above (rectangle 5 10 "solid" "black")       ;gun
                     (rectangle 20 10 "solid" "black"))))   ;main body

(define TANK-HEIGHT/2 (/ (image-height TANK) 2))
(define TANK-Y-POSITION (- HEIGHT TANK-HEIGHT/2))

(define MISSILE (ellipse 5 15 "solid" "red"))

(define MISSILE-HEIGHT/2 (/ (image-height MISSILE) 2))
(define MISSILE-STARTING-Y (- (- TANK-Y-POSITION TANK-HEIGHT/2) MISSILE-HEIGHT/2))



;; Data Definitions:

(define-struct game (invaders missiles tank))
;; Game is (make-game  (listof Invader) (listof Missile) Tank)
;; interp. the current state of a space invaders game
;;         with the current invaders, missiles and tank position

;; Game constants defined below Missile data definition

#;
(define (fn-for-game s)
  (... (fn-for-loinvader (game-invaders s))
       (fn-for-lom (game-missiles s))
       (fn-for-tank (game-tank s))))



(define-struct tank (x dir))
;; Tank is (make-tank Number Integer[-1, 1])
;; interp. the tank location is x, HEIGHT - TANK-HEIGHT in screen coordinates
;;         the tank moves TANK-SPEED pixels per clock tick left if dir -1, right if dir 1

(define T0 (make-tank (/ WIDTH 2) 1))   ;center going right
(define T1 (make-tank 50 1))            ;going right
(define T2 (make-tank 50 -1))           ;going left

#;
(define (fn-for-tank t)
  (... (tank-x t) (tank-dir t)))



(define-struct invader (x y dx))
;; Invader is (make-invader Number Number Integer[-1, 1])
;; interp. the invader is at (x, y) in screen coordinates
;;         dx is direction of x movement left if -1, right if 1

(define I1 (make-invader 150 100 1))           ;not landed, moving right
(define I2 (make-invader 150 HEIGHT -1))       ;exactly landed, moving left
(define I3 (make-invader 150 (+ HEIGHT 10) 1)) ;> landed, moving right


#;
(define (fn-for-invader invader)
  (... (invader-x invader) (invader-y invader) (invader-dx invader)))


(define-struct missile (x y))
;; Missile is (make-missile Number Number)
;; interp. the missile's location is x y in screen coordinates

(define M1 (make-missile 150 300))                       ;not hit U1
(define M2 (make-missile (invader-x I1) (+ (invader-y I1) 10)))  ;exactly hit U1
(define M3 (make-missile (invader-x I1) (+ (invader-y I1)  5)))  ;> hit U1

#;
(define (fn-for-missile m)
  (... (missile-x m) (missile-y m)))



(define G0 (make-game empty empty T0))
(define G1 (make-game empty empty T1))
(define G2 (make-game (list I1) (list M1) T1))
(define G3 (make-game (list I1 I2) (list M1 M2) T1))



;; Functions:

;; Game -> Game
;; start the world with (main G0)
;; 
(define (main s)
  (big-bang s                            ; Game
            (on-tick   advance-game)     ; Game -> Game
            (to-draw   render-game)      ; Game -> Image
            (stop-when game-over?)       ; Game -> Boolean
            (on-key    handle-keys)))    ; Game KeyEvent -> Game

;; Game -> Game
;; produce the next game state

;(define (advance-game s) s) ; stub

(define (advance-game s)
  (make-game (advance-invaders (game-invaders s))
             (advance-missiles (game-missiles s))
             (advance-tank (game-tank s))))


;; ListOfInvader -> ListOfInvader
;; produce the next invaders state
;;!!!
(define (advance-invaders loinvader) loinvader) ; stub


;; ListOfMissile -> ListOfMissile
;; produce the next missiles state
;; !!!
(define (advance-missiles lom) lom) ; stub


;; Tank -> Tank
;; produce the next tank state
;; !!!
(define (advance-tank t) t) ; stub


;; Game -> Image
;; render the game state as an image
(check-expect (render-game G1)
              (place-image TANK 50 TANK-Y-POSITION BACKGROUND))
(check-expect (render-game G2)
              (place-image INVADER 150 100
                           (place-image MISSILE 150 300
                                        (place-image TANK 50 TANK-Y-POSITION BACKGROUND))))
(check-expect (render-game G3)
              (place-image INVADER 150 100
                           (place-image INVADER 150 HEIGHT
                                        (place-image MISSILE 150 300
                                                     (place-image MISSILE (invader-x I1) (+ (invader-y I1) 10)
                                                                  (place-image TANK 50 TANK-Y-POSITION BACKGROUND))))))

;(define (render-game s) empty-image) ; stub

(define (render-game s)
  (render-invaders (game-invaders s)
                   (render-missiles (game-missiles s)
                                    (render-tank (game-tank s) BACKGROUND))))


;; ListOfInvader Image -> Image
;; render loinvader on img
(check-expect (render-invaders empty BACKGROUND) BACKGROUND)
(check-expect (render-invaders (list I1) BACKGROUND) (place-image INVADER 150 100 BACKGROUND))
(check-expect (render-invaders (list I1 I2) BACKGROUND)
              (place-image INVADER 150 100
                           (place-image INVADER 150 HEIGHT BACKGROUND)))

;(define (render-invaders loinvader img) img) ; stub

(define (render-invaders loinvader img)
  (cond
    [(empty? loinvader) img]
    [else (place-image INVADER 
                       (invader-x (first loinvader)) 
                       (invader-y (first loinvader))
                       (render-invaders (rest loinvader) img))]))


;; ListOfMissile Image -> Image
;; render lom on img
(check-expect (render-missiles empty BACKGROUND) BACKGROUND)
(check-expect (render-missiles (list M1) BACKGROUND) (place-image MISSILE 150 300 BACKGROUND))
(check-expect (render-missiles (list M1 M2) BACKGROUND)
              (place-image MISSILE 150 300
                           (place-image MISSILE (invader-x I1) (+ (invader-y I1) 10) BACKGROUND)))

;(define (render-missiles lom img) img) ; stub

(define (render-missiles lom img)
  (cond
    [(empty? lom) img]
    [else (place-image MISSILE 
                       (missile-x (first lom)) 
                       (missile-y (first lom))
                       (render-missiles (rest lom) img))]))


;; Tank Image -> Image
;; render t on img
(check-expect (render-tank T1 BACKGROUND) (place-image TANK 50 TANK-Y-POSITION BACKGROUND))

;(define (render-tank t img) img) ; stub

(define (render-tank t img)
  (place-image TANK (tank-x t) TANK-Y-POSITION img))


;; Game -> Boolean
;; produce true if any of the invaders have landed
(check-expect (game-over? G1) false)
(check-expect (game-over? G2) false)
(check-expect (game-over? G3) true)

;(define (game-over? s) false) ;stub

(define (game-over? s)
  (landed? (game-invaders s)))

;; ListOfInvader -> Boolean
;; produce true if any invader's y postion is greater than or equal to HEIGHT
(check-expect (landed? (list I1)) false)
(check-expect (landed? (list I1 I2)) true)
(check-expect (landed? (list I3 I1)) true)

;(define (landed? loinvader) false) ; stub

(define (landed? loinvader)
  (cond [(empty? loinvader) false]
        [else (if (>= (invader-y (first loinvader)) HEIGHT)
                  true
                  (landed? (rest loinvader)))]))


;; Game KeyEvent -> Game
;;  - on " " fire a missile
;;  - on "left" change tank direction to -1
;;  - on "right" change tank direction to 1
(check-expect (handle-keys G1 " ") (make-game empty (list (make-missile 50 MISSILE-STARTING-Y)) T1))
(check-expect (handle-keys G1 "left") (make-game empty empty (make-tank 50 -1)))
(check-expect (handle-keys G1 "right") (make-game empty empty (make-tank 50 1)))
(check-expect (handle-keys G1 "a") G1)

;(define (handle-keys s ke) s) ; stub

(define (handle-keys s ke)
  (cond
    [(key=? ke " ") (make-game (game-invaders s) (cons (make-missile (tank-x (game-tank s)) MISSILE-STARTING-Y) (game-missiles s)) (game-tank s))]
    [(key=? ke "left") (make-game (game-invaders s) (game-missiles s) (make-tank (tank-x (game-tank s)) -1))]
    [(key=? ke "right") (make-game (game-invaders s) (game-missiles s) (make-tank (tank-x (game-tank s)) 1))]
    [else s]))