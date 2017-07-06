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
  (advance-all (remove-collisions s)))


;; Game -> Game
;; advance all parts of game

;(define (advance-all s) s) ; stub

(define (advance-all s)
  (make-game (add-invader (advance-invaders (game-invaders s)))
             (advance-missiles (game-missiles s))
             (advance-tank (game-tank s))))


;; Game -> Game
;; remove invaders and missiles that collide
(check-expect (remove-collisions G1) G1)
(check-expect (remove-collisions G2) G2)
(check-expect (remove-collisions G3) (make-game (list I2) (list M1) T1))

;(define (remove-collisions s) s) ; stub

(define (remove-collisions s)
  (make-game (remove-overlaps-invaders (game-invaders s) (game-missiles s))
             (remove-overlaps-missiles (game-missiles s) (game-invaders s))
             (game-tank s)))


;; ListOfInvader ListOfMissile -> ListOfInvader
;; produce list loinvader without overlaps with lom
(check-expect (remove-overlaps-invaders empty empty) empty)
(check-expect (remove-overlaps-invaders empty (list M1)) empty)
(check-expect (remove-overlaps-invaders (list I1 I2) (list M1)) (list I1 I2))
(check-expect (remove-overlaps-invaders (list I1 I2) (list M1 M2)) (list I2))

;(define (remove-overlaps-invaders loinvader lom) loinvader) ; stub

(define (remove-overlaps-invaders loinvader lom)
  (cond
    [(empty? loinvader) empty]
    [(empty? lom) loinvader]
    [(overlaps-invader? (first loinvader) lom) (remove-overlaps-invaders (rest loinvader) lom)]
    [else (cons (first loinvader) (remove-overlaps-invaders (rest loinvader) lom))]))


;; ListOfMissile ListOfInvader -> ListOfMissile
;; produce list loinvader without overlaps with lom
(check-expect (remove-overlaps-missiles (list M1) empty) (list M1))
(check-expect (remove-overlaps-missiles (list M1 M2) (list I2)) (list M1 M2))
(check-expect (remove-overlaps-missiles (list M1 M2) (list I1 I2)) (list M1))

;(define (remove-overlaps-missiles lom loinvader) loinvader) ; stub

(define (remove-overlaps-missiles lom loinvader)
  (cond
    [(empty? lom) empty]
    [(empty? loinvader) lom]
    [(overlaps-missile? (first lom) loinvader) (remove-overlaps-missiles (rest lom) loinvader)]
    [else (cons (first lom) (remove-overlaps-missiles (rest lom) loinvader))]))


;; Invader ListOfMissile -> Boolean
;; produce true if item overlaps with list
(check-expect (overlaps-invader? I1 (list M1)) false)
(check-expect (overlaps-invader? I1 (list M1 M2)) true)

;(define (overlaps-invader? i lom) true) ; stub

(define (overlaps-invader? i lom)
  (cond
    [(empty? lom) false]
    [(close-enough? i (first lom)) true]
    [else
     (overlaps-invader? i (rest lom))]))


;; Missile ListOfInvader -> Boolean
;; produce true if item overlaps with list
(check-expect (overlaps-missile? M2 (list I2)) false)
(check-expect (overlaps-missile? M2 (list I1 I2)) true)

;(define (overlaps-missile? m loinvader) true) ; stub

(define (overlaps-missile? m loinvader)
  (cond
    [(empty? loinvader) false]
    [(close-enough? (first loinvader) m) true]
    [else
     (overlaps-missile? m (rest loinvader))]))


;; Invader Missile -> Boolean
;; produce true if items' x and y are within HIT-RANGE
(check-expect (close-enough? I1 M1) false)
(check-expect (close-enough? I1 M2) true)

;(define (close-enough? i m) true) ; stub

(define (close-enough? i m)
  (and (<= (abs (- (invader-x i) (missile-x m))) HIT-RANGE)
       (<= (abs (- (invader-y i) (missile-y m))) HIT-RANGE)))


;; ListOfInvader -> ListOfInvader
;; randomly add an invader to loinvader
(check-random (add-invader empty)
              (if (< (random INVADE-RATE) 3)
                  (cons (make-invader (random WIDTH) 0 1) empty)
                  empty))

;(define (add-invader loinvader) loinvader) ; stub

(define (add-invader loinvader)
  (if (< (random INVADE-RATE) 3)
      (cons (make-invader (random WIDTH) 0 1) loinvader)
      loinvader))


;; ListOfInvader -> ListOfInvader
;; produce the next invaders state
(check-expect (advance-invaders empty) empty)
(check-expect (advance-invaders (list I1)) (cons (make-invader (+ 150 (* INVADER-X-SPEED 1)) (+ 100 INVADER-Y-SPEED) 1) empty))
(check-expect (advance-invaders (list (make-invader WIDTH 100 1))) (cons (make-invader WIDTH 100 -1) empty))
(check-expect (advance-invaders (list (make-invader 0 100 -1))) (cons (make-invader 0 100 1) empty))
(check-expect (advance-invaders (list I1 I2))
              (cons (make-invader (+ 150 (* INVADER-X-SPEED 1)) (+ 100 INVADER-Y-SPEED) 1)
                    (cons (make-invader (+ 150 (* INVADER-Y-SPEED -1)) (+ HEIGHT INVADER-Y-SPEED) -1) empty)))

;(define (advance-invaders loinvader) loinvader) ; stub

(define (advance-invaders loinvader)
  (cond
    [(empty? loinvader) empty]
    [else
     (cons (advance-invader (first loinvader))
           (advance-invaders (rest loinvader)))]))


;; Invader -> Invader
;; produce the next invader state
(check-expect (advance-invader I1) (make-invader (+ 150 (* INVADER-X-SPEED 1)) (+ 100 INVADER-Y-SPEED) 1))
(check-expect (advance-invader I2) (make-invader (+ 150 (* INVADER-X-SPEED -1)) (+ HEIGHT INVADER-Y-SPEED) -1))
(check-expect (advance-invader (make-invader WIDTH 100 1)) (make-invader WIDTH 100 -1))
(check-expect (advance-invader (make-invader 0 100 -1)) (make-invader 0 100 1))

;(define (advance-invader i) i) ; stub

(define (advance-invader i)
  (if (edge? i)
      (make-invader (invader-x i) (invader-y i) (* (invader-dx i) -1))
      (make-invader (+ (invader-x i) (* INVADER-X-SPEED (invader-dx i))) 
                    (+ (invader-y i) INVADER-Y-SPEED) 
                    (invader-dx i))))


;; Invader -> Boolean
;; produce true if i is on the edge and needs to be turned
(check-expect (edge? I1) false)
(check-expect (edge? I2) false)
(check-expect (edge? (make-invader WIDTH 100 1)) true)
(check-expect (edge? (make-invader 0 100 -1)) true)
(check-expect (edge? (make-invader (+ WIDTH 1) 100 1)) true)
(check-expect (edge? (make-invader -1 100 -1)) true)
(check-expect (edge? (make-invader WIDTH 100 -1)) false)
(check-expect (edge? (make-invader 0 100 1)) false)

;(define (edge? i) true) ; stub

(define (edge? i)
  (or (and (>= (invader-x i) WIDTH) (= (invader-dx i) 1))
      (and (<= (invader-x i) 0) (= (invader-dx i) -1))))


;; ListOfMissile -> ListOfMissile
;; produce the next missiles state
(check-expect (advance-missiles empty) empty)
(check-expect (advance-missiles (list M1)) 
              (cons (make-missile 150 (- 300 MISSILE-SPEED)) empty))
(check-expect (advance-missiles (list M1 M2)) 
              (cons (make-missile 150 (- 300 MISSILE-SPEED)) 
                    (cons (make-missile (invader-x I1) (- (+ (invader-y I1) 10) MISSILE-SPEED)) empty)))


;(define (advance-missiles lom) lom) ; stub

(define (advance-missiles lom)
  (cond
    [(empty? lom) empty]
    [(off-screen? (first lom)) (advance-missiles (rest lom))]
    [else
     (cons (advance-missile (first lom)) 
           (advance-missiles (rest lom)))]))


;; Missile -> Boolean
;; produce true if the missile is off-screen (it's y<0)
(check-expect (off-screen? M1) false)
(check-expect (off-screen? (make-missile 150 -1)) true)

;(define (off-screen? m) true) ; stub

(define (off-screen? m)
  (< (missile-y m) 0))


;; Missile -> Missile
;; produce the next missile state
(check-expect (advance-missile M1) (make-missile 150 (- 300 MISSILE-SPEED)))

;(define (advance-missile m) m) ; stub

(define (advance-missile m)
  (make-missile (missile-x m)
                (- (missile-y m) MISSILE-SPEED)))


;; Tank -> Tank
;; produce the next tank state
(check-expect (advance-tank T1) (make-tank (+ 50 (* TANK-SPEED 1)) 1))
(check-expect (advance-tank T2) (make-tank (+ 50 (* TANK-SPEED -1)) -1))

;(define (advance-tank t) t) ; stub

(define (advance-tank t)
  (make-tank (+ (tank-x t) (* TANK-SPEED (tank-dir t))) (tank-dir t)))


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