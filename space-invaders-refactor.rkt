;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname space-invaders-refactor) (read-case-sensitive #t) (teachpacks ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp"))) (htdp-settings #(#t constructor repeating-decimal #f #t none #f ((lib "convert.rkt" "teachpack" "htdp") (lib "image.rkt" "teachpack" "2htdp")) #f)))
(require 2htdp/image)
(require 2htdp/universe)


;;;; Data Definitions

(define LEFT 'left)
(define RIGHT 'right)


;; A Direction is one of
;; - LEFT
;; - RIGHT
;; INTERP: represnts the spaceship's direction

;; Deconstructor Templatea
;; direction-fn: Direction -> ???
#;(define (direction-fn direction)
    (cond
      [(symbol? LEFT direction)...]
      [(symbol? RIGHT direction)...]))


;; A SpaceShip is (make-spaceship Direction PosNumber)
;; INTERP: represents a spaceship with direction and the x-coordinate of the
;;         spaceship location on canvas 
(define-struct spaceship (dir location-x))


;; Deconstructor Template
;; spaceship-fn: SpaceShip -> ...?
#;(define (spaceship-fn spaceship)
    ...(direction-fn (spaceship-dir spaceship))...
    ...(spaceship-location-x spaceship)..)

;; A List<X> is one of  
;; - empty  
;; - (cons X List<X>)

;; Deconstructor Template
;; lox-fn: List<X> -> ???
#;(define (lox-fn loi)
    (cond
      [(empty? lox) ...]
      [(cons? lox) ... (first lox)...
                   ... (lox-fn (rest lox))...]))

;; An Invader is a Posn
;; INTERP: represnts one invader on the canvas

;; A SpaceshipBullet(SB) is a Posn
;; INTERP: represents a spaceship bullet on the canvas

;; An InvaderBullet(IB) is a Posn
;; INTERP: represents an invader bullet on the canvas

;; A Score is an NonNegInteger
;; INTERP: represents the game score


(define LIFE-INIT 3)
;; A Life is a NonNegInteger
;; WHERE: 0 <= Life <= LIFE-INIT
;; INTERP: represents the number of lives the game allows


(define INVADER-MOVE-TICK 45)
;; A TickNumber is a NonNegInteger
;; WHERE: 0 <= TickNumber <= INVADER-MOVE-TICKS
;; INTERP: represents the number of clock ticks from the invaders
;;         move last time 


;; A World is (make-world SpaceShip List<Invader> List<SB>
;;             List<IB> Score TickNumber)
;; INTERP: spaceship represents the spaceship in the game
;;         List<Invader> represents the invaders in the game
;;         List<SB> represents the spaceship bullets in the game
;;         List<IB> represents the invader bullets in the game
;;         Score represents the score
;;         TickNumber represents the number of clock ticks from the invaders
;;         move last time

(define-struct world (spaceship loi losb loib score life tick))

;; Deconstructor Template
;; world-fn: World -> ???
#;(define (world-fn world)
    ... (spaceship-fn (world-spaceship world))...
    ... (loi-fn (world-lol world))...
    ... (losb-fn (world-losb world))...
    ... (loib-fn (world-loib world))...
    ... (world-score world)...
    ... (world-life world)...
    ... (world-tick world)...)

(define WIDTH 700)
(define HEIGHT 700)
(define BACKGROUND (empty-scene WIDTH HEIGHT)) 

(define INVADER-SIDE 30)
(define ROW-SPACE 15)
(define INVADER-SPACE 30)
(define INVADER-IMAGE (square INVADER-SIDE 'solid 'red))
 
(define SPACESHIP-WIDTH 50)
(define SPACESHIP-HEIGHT 20)
(define SPACESHIP-Y 680)
(define SPACESHIP-SPEED 10)
(define SPACESHIP-IMAGE
  (rectangle SPACESHIP-WIDTH SPACESHIP-HEIGHT 'solid 'black))

(define BULLET-SIDE 5)
(define BULLET-SPEED 10)
(define INVADER-BULLET-IMAGE (square BULLET-SIDE 'solid 'red))
(define SPACESHIP-BULLET-IMAGE (square BULLET-SIDE 'solid 'black))

(define INVADE-BULLET-DISTANCE (/ (+ INVADER-SIDE BULLET-SIDE) 2))

(define SPACESHIP-BULLET-LIMIT 3)
(define INVADER-BULLET-LIMIT 10)

(define RANDOM-RANGE 19)
(define FIRE-CAP 5)

(define SPACESHIP-INIT (make-spaceship RIGHT 350))
(define LOSB-INIT empty)
(define LOIB-INIT empty)

(define INVADER41 (make-posn 110 60))
(define INVADER42 (make-posn 170 60))
(define INVADER43 (make-posn 230 60))
(define INVADER44 (make-posn 290 60))
(define INVADER45 (make-posn 350 60))
(define INVADER46 (make-posn 410 60))
(define INVADER47 (make-posn 470 60))
(define INVADER48 (make-posn 530 60))
(define INVADER49 (make-posn 590 60))

  
(define INVADER31 (make-posn 110 105))
(define INVADER32 (make-posn 170 105))
(define INVADER33 (make-posn 230 105))
(define INVADER34 (make-posn 290 105)) 
(define INVADER35 (make-posn 350 105))
(define INVADER36 (make-posn 410 105))
(define INVADER37 (make-posn 470 105))
(define INVADER38 (make-posn 530 105))
(define INVADER39 (make-posn 590 105))

(define INVADER21 (make-posn 110 150))
(define INVADER22 (make-posn 170 150))
(define INVADER23 (make-posn 230 150))
(define INVADER24 (make-posn 290 150))
(define INVADER25 (make-posn 350 150))
(define INVADER26 (make-posn 410 150))
(define INVADER27 (make-posn 470 150))
(define INVADER28 (make-posn 530 150))
(define INVADER29 (make-posn 590 150))

(define INVADER11 (make-posn 110 195))
(define INVADER12 (make-posn 170 195))
(define INVADER13 (make-posn 230 195))
(define INVADER14 (make-posn 290 195))
(define INVADER15 (make-posn 350 195))
(define INVADER16 (make-posn 410 195))
(define INVADER17 (make-posn 470 195))
(define INVADER18 (make-posn 530 195))
(define INVADER19 (make-posn 590 195))

(define LOI-INIT
  (list INVADER41 INVADER42 INVADER43 INVADER44 INVADER45 INVADER46 INVADER47
        INVADER48 INVADER49 INVADER31 INVADER32 INVADER33 INVADER34 INVADER35
        INVADER36 INVADER37 INVADER38 INVADER39 INVADER21 INVADER22 INVADER23
        INVADER24 INVADER25 INVADER26 INVADER27 INVADER28 INVADER29 INVADER11
        INVADER12 INVADER13 INVADER14 INVADER15 INVADER16 INVADER17 INVADER18
        INVADER19))

(define SCORE-X 350)
(define SCORE-Y 30)
(define SCORE-SIZE 20)
(define SCORE-COLOR "black")
(define SCORE-INCREMENT 3)
(define SCORE-INIT 0)

(define LIFE-X 660)
(define LIFE-Y 660)
(define LIFE-SIZE 20)
(define LIFE-COLOR "red")
(define LIFE-DECREMENT 1)


(define TICK-INIT 0)
(define TICK-INCREMENT 1)

(define WORLD-INIT (make-world SPACESHIP-INIT LOI-INIT LOSB-INIT LOIB-INIT
                               SCORE-INIT LIFE-INIT TICK-INIT))


  
;;;; Signature
;; world-draw : World -> Image
;;;; Purpose
;; GIVEN: a world
;; RETURNS: an image representing the given world
;;;; Function Definition
(define (world-draw world)
  (local (;;;; Signature
          ;; draw-life: Life Image -> Image
          ;;;; Purpose
          ;; GIVEN: a number of available lives and an image
          ;; RETURNS: a new image with the number of available lived on the
          ;; image
          ;;;; Function Definition
          (define (draw-life lf img)
            (place-image (text (string-append "Life " (number->string lf))
                               LIFE-SIZE LIFE-COLOR) LIFE-X LIFE-Y img))
          ;;;; Signature
          ;; draw-score: Score Image -> Image
          ;;;; Purpose
          ;; GIVEN: a score and an image
          ;; RETURNS: a new image with the score on the image
          ;;;; Function Definition
          (define (draw-score n img)
            (place-image (text (string-append "Score " (number->string n))
                               SCORE-SIZE SCORE-COLOR) SCORE-X  SCORE-Y img))
          ;;;; Signature
          ;; draw-loi: List<Invadrer> -> Image
          ;;;; Purpose
          ;; GIVEN: a list of invaders
          ;; RETURNS: an image with the invaders on the background(BACKGROUND)
          ;;;; Function Definitioin
          (define (draw-loi loi)
            (foldl (λ (a b) (place-image INVADER-IMAGE
                                         (posn-x a) (posn-y a) b))
                   BACKGROUND loi))
          ;;;; Siganture
          ;; draw-spaceship: SpaceShip Image -> Image
          ;;;; Purpose
          ;; GIVEN: a SpaceShip and an Image
          ;; RETURN: a new image that draws the spaceship on the given image
          ;;;; Function Definition
          (define (draw-spaceship spaceship img)
            (place-image SPACESHIP-IMAGE (spaceship-location-x spaceship)
                         SPACESHIP-Y img))
          ;;;; Signature
          ;; draw-spaceship-bullets: List<SB> Image -> Image
          ;;;; Purpsoe
          ;; GIVEN: a list of spaceship bullets and an image
          ;; RETURNS: a new image that draws the spaceship bullets in the list
          ;;          on the given image
          ;;;; Function Definition
          (define (draw-spaceship-bullets losb img)
            (foldl (λ (a b) (place-image SPACESHIP-BULLET-IMAGE
                                         (posn-x a) (posn-y a) b)) img losb))
          ;;;; Signature
          ;; draw-invader-bullets: List<IB> Image -> Image
          ;;;; Purpose
          ;; GIVEN : a list of invader bullets and a image
          ;; RETURNS: a new image that draws the invader bullets in the list
          ;;          on the given image
          ;;;; Function Definition
          (define (draw-invader-bullets loib img)
            (foldl (λ (a b) (place-image INVADER-BULLET-IMAGE
                                         (posn-x a) (posn-y a) b)) img loib)))
    (draw-life (world-life world)
               (draw-score (world-score world)
                           (draw-invader-bullets (world-loib world)
                                                 (draw-spaceship-bullets
                                                  (world-losb world)
                                                  (draw-spaceship
                                                   (world-spaceship world)
                                                   (draw-loi
                                                    (world-loi world)))))))))


 
;;;;Siganture
;; world-step: World -> World
;;;; Purpose
;; GIVEN: the current world
;; RETURNS: the next world after one clock tick
;;;; Function Definition
(define (world-step w)
  (local
    (;;;; Signature
     ;; remove-hits-out-of-bounds-and-update-score: World -> World
     ;;;; Purpose
     ;; GIVEN: a world
     ;; RETURNS: an updated world with all the invaders that have been hit by
     ;;          a spaceship bullet and all bullets that are out of bounds
     ;;          removed and score updated 
     ;;;; Function Definitioin
     (define (remove-hits-out-of-bounds-and-update-score w)
       (local
         (;;;; Signature
          ;; remove-invader-bullets: List<IB> -> List<IB>
          ;;;; Purpose
          ;; GIVEN: a list of invader bullets
          ;; RETURNS: an updated list of invader bullets with the bullets
          ;;          out of bounds removed
          ;;;; Function Definition
          (define (remove-invader-bullets loib)
            (filter (λ (x) (< (posn-y x) HEIGHT)) loib))
          ;;;; Signature
          ;; hit-invader?: SpaceshipBullet Invader -> Boolean
          ;;;; Purpose
          ;; GIVEN: a spaceship bullet and an invader
          ;; RETURNS: true if the given spaceship bullet hits
          ;; the given invaders, flase otherwise
          (define (hit-invader? sb iv)
            (and (> (posn-x sb)(- (posn-x iv) INVADE-BULLET-DISTANCE))
                 (< (posn-x sb)(+ (posn-x iv) INVADE-BULLET-DISTANCE))
                 (> (posn-y sb)(- (posn-y iv) INVADE-BULLET-DISTANCE))
                 (< (posn-y sb)(+ (posn-y iv) INVADE-BULLET-DISTANCE))))
          
          ;;;; Signature
          ;; hit-invaders?: SpaceshipBullet List<Invader> -> Boolean
          ;;;; Purpose
          ;; GIVEN: a spaceship bullet and all invaders in the
          ;;        current game
          ;; RETURNS: true if the given spaceship bullet hits
          ;;          any invaders, flase otherwise
          (define (hit-invaders? sb loi)
            (ormap (λ (x) (hit-invader? sb x)) loi))

          ;;;; Signature
          ;; update-score: List<SB> List<Invader> Score -> Score
          ;;;; Purpose
          ;; GIVEN: a list of spaceship bullets, a score and all invaders
          ;;        in the current game
          ;; RETURNS: the updated score with SCORE-INCREMENT points added
          ;;          for each invader hit by a spaceship bullets
          ;;;; Function Definition
          (define (update-score losb loi score)
            (local (;;;; Signature
                    ;; add-score: SpaceshipBullet -> NonNegInteger
                    ;;;; Purpose
                    ;; GIVEN: a spaceship bullet and a score in the current
                    ;;        game
                    ;; RETURNS: SCORE-INCREMENT points if the spaceship bullets
                    ;;          hit any of the invaders, 0 otherwise
                    (define (add-score sb)
                      (cond
                        [(hit-invaders? sb loi) SCORE-INCREMENT]
                        [else 0])))
              (foldl + score (map add-score losb))))
          ;;;; Signature
          ;; remove-spaceship-bullets: List<Invader> List<SB> -> List<SB>
          ;;;; Purpose
          ;; GIVEN: all invaders and a list of spaceship bullets in the current
          ;;        game
          ;; RETURNS: the updated list of spaceship bullets with
          ;;          all bullets that hit the invaders or go out of bounds
          ;;          removed
          ;;;; Function Definition
          (define (remove-spaceship-bullets loi losb)
            (filter (λ (x) (and (> (posn-y x) 0)
                                (not (hit-invaders? x loi)))) losb))
          ;;;; Signature
          ;; remove-invader: List<Invader> List<SB> -> List<Invader>
          ;;;; Purpose
          ;; GIVEN: all invaders and a list of spaceship bullets in the current
          ;;        game
          ;; RETURNS: the updated invaders with the ones hit by any spaceship
          ;           bullets removed
          ;;;; Function Definition
          (define (remove-invader loi losb)
            (local (;;;; Signature
                    ;; not-hit?: Invader -> Boolean
                    ;; GIVEN: an invader and a list of spaceship bullets
                    ;; RETURNS: true if the invader not hit by any of the
                    ;;          bullets in the list, false otherwise
                    (define (not-hit? iv)
                      (andmap (λ (x) (not (hit-invader? x iv))) losb)))
              (filter not-hit? loi))))

    
         (make-world (world-spaceship w)
                     (remove-invader (world-loi w) (world-losb w))
                     (remove-spaceship-bullets (world-loi w) (world-losb w))
                     (remove-invader-bullets (world-loib w))
                     (update-score (world-losb w)
                                   (world-loi w)
                                   (world-score w))
                     (world-life w)
                     (world-tick w))))
     ;;;; Signature
     ;; update-life: World -> World
     ;;;; Purpose
     ;; GIVEN: a world
     ;; RETURNS: an updated world with the spaceship in the center and one life
     ;;          removed and the invader bullet removed if the spaceship is hit
     ;;          by that invader's bullet, otherwise the unchanged world
     (define (update-life w)
       (local (;;;; Signature
               ;; ship-hit-by-one: Spaceship InvaderBullet -> Boolean
               ;;;; Purpose
               ;; GIVEN: a spaceship and an invader bullets
               ;; RETURNS: true if the given bullet hit the ship,
               ;;          false otherwise
               (define (ship-hit-by-one sp ib)
                 (and (< (spaceship-location-x sp)
                         (+ (posn-x ib) (/ BULLET-SIDE 2)
                            (/ SPACESHIP-WIDTH 2)))
                      (> (spaceship-location-x sp)
                         (- (posn-x ib) (/ BULLET-SIDE 2)
                            (/ SPACESHIP-WIDTH 2)))
                      (< SPACESHIP-Y
                         (+ (posn-y ib) (/ BULLET-SIDE 2)
                            (/ SPACESHIP-HEIGHT 2)))
                      (> SPACESHIP-Y
                         (- (posn-y ib) (/ BULLET-SIDE 2)
                            (/ SPACESHIP-HEIGHT 2)))))
               ;;;; Signature
               ;; ship-hit: Spaceship List<IB> -> Boolean
               ;;;; Purpose
               ;; GIVEN: a spaceship and a list of invader bullets
               ;; RETURNS: true if any bullet in the list of invader bullets
               ;;          hits the ship, false otherwise 
               ;;;; Function Definition
               (define (ship-hit sp loib)
                 (ormap (λ (x) (ship-hit-by-one sp x)) loib))
               ;;;; Signature
               ;; remove-hit-invader-bullet: Spaceship List<IB> -> List<IB>
               ;;;; Purpose
               ;; GIVEN: a list of invader bullets and a spaceship
               ;; RETURNS: an updated list of invader bullets with the bullets
               ;;          hit the spaceship removed
               ;;;; Function Definition
               (define (remove-hit-invader-bullet sp loib)
                 (filter (λ (x) (not (ship-hit-by-one sp x))) loib)))
         (cond      
           [(ship-hit (world-spaceship w) (world-loib w))
            (make-world (world-spaceship WORLD-INIT)
                        (world-loi w)
                        (world-losb w)
                        (remove-hit-invader-bullet
                         (world-spaceship w) (world-loib w))
                        (world-score w)
                        (- (world-life w) LIFE-DECREMENT)
                        (world-tick w))]
           [else w])))
     ;;;; Siganture
     ;; pre-world-step: World -> World
     ;;;; Purpose
     ;; GIVEN: the current world
     ;; RETURNS: the next world after one clock tick before update the number
     ;;          of available lives
     ;;;; Function Definition
     (define (pre-world-step w)            
       (local
         (;;;; Signature
          ;; move-spaceship: Spaceship -> Spaceship
          ;;;; Purpose
          ;; GIVEN: a spaceship
          ;; RETURNS: the spaceship after it moves by SPACESHIP-SPEED distance
          ;;          in the appropriate direction or the spaceship at the edge
          ;;          if it reaches the edge 
          ;;;; Function Definition
          (define (move-spaceship sp)
            (make-spaceship
             (spaceship-dir sp)
             (local
               (;;;; Signature
                ;; update-spaceship-x: Spaceship -> Number
                ;;;; Purpose
                ;; GIVEN: a spaceship
                ;; RETURNS: the x-coordinate of the spaceship position after
                ;;          one clock tick
                ;;;; Function Definition
                (define (update-spaceship-x sp)
                  (local
                    (;;;; Signature
                     ;; reach-left: Spaceship -> Boolean
                     ;;;; Purpose
                     ;; GIVEN: a spaceship
                     ;; RETURNS: true if the spaceship has reached the left
                     ;;          side edge of the scene, false otherwise
                     (define (reach-left sp)
                       (< (spaceship-location-x sp)
                          (+ SPACESHIP-SPEED
                             (/ SPACESHIP-WIDTH 2))))
                     ;;;; Signature
                     ;; reach-right: Spaceship -> Boolean
                     ;;;; Purpose
                     ;; GIVEN: a spaceship
                     ;; RETURNS: true if the spaceship has reached the right
                     ;;          side edge of the scene, false otherwise
                     (define (reach-right sp)
                       (> (spaceship-location-x sp)
                          (- WIDTH SPACESHIP-SPEED
                             (/ SPACESHIP-WIDTH 2)))))
                    (cond
                      [(and (symbol=? LEFT (spaceship-dir sp))
                            (reach-left sp))
                       (/ SPACESHIP-WIDTH 2)]
                      [(symbol=? LEFT (spaceship-dir sp))
                       (- (spaceship-location-x sp) SPACESHIP-SPEED)]
                      [(and (symbol=? RIGHT (spaceship-dir sp))
                            (reach-right sp))
                       (- WIDTH (/ SPACESHIP-WIDTH 2))]
                      [(symbol=? RIGHT (spaceship-dir sp))
                       (+ (spaceship-location-x sp)
                          SPACESHIP-SPEED)]))))
               (update-spaceship-x sp))))



                
          ;;;; Signature
          ;; move-invaders:
          ;; List<Invader> TickNumber -> List<Invader>
          ;;;; Purpose
          ;; GIVEN: all invaders and the number of clock ticks from the last
          ;;        invader movein the current game
          ;; RETURNS: the invaders move downward towards the spaceship by half
          ;;          the height of an invader if the clock tick number reach
          ;;          INVADER-MOVE-TICK, otherwise the current invaders
          (define (move-invaders loi t)
            (cond
              [(< t INVADER-MOVE-TICK)
               loi]
              [else
               (local (;;;; Signature
                       ;; move-invader: Invader -> Invader
                       ;;;; Purpsoe
                       ;; GIVEN: an invader
                       ;; RETURNS: a new invader that is downward towards the
                       ;;          spaceship by half the height of an invader
                       ;;          from the given invader
                       (define (move-invader iv)
                         (make-posn (posn-x iv)
                                    (+ (posn-y iv)
                                       (/ INVADER-SIDE 2)))))
                 (map move-invader loi))]))
                
          ;;;; Signature
          ;; move-spaceship-bullets: List<SB> -> List<SB>
          ;;;; Purpose 
          ;; GIVEN: a list of spaceship bullets
          ;; RETURNS: the list of spaceship bullets that have upwarded by
          ;;          BULLET-SPEED units
          ;;;; Function Definition
          (define (move-spaceship-bullets losb)
            (local ( ;;;; Signature
                    ;; move-spaceship-bullet: SpaceshipBulet -> SpaceshipBullet
                    ;;;; Purpose
                    ;; GIVEN: a spaceship bullet
                    ;; RETURNS: the spaecship bullet after upwarded by
                    ;;          BULLET-SPEED
                    (define (move-spaceship-bullet sb)
                      (make-posn (posn-x sb)
                                 (- (posn-y sb) BULLET-SPEED))))
              (map move-spaceship-bullet losb)))
          ;;;; Signature
          ;; move-invader-bullets: List<IB> -> List<IB>
          ;;;; Purpose
          ;; GIVEN: a list of invader bullets
          ;; RETURNS: the list of invader bullets that have upwarded by
          ;;          BULLET-SPEED units
          ;;;; Function Definition
          (define (move-invader-bullets loib)
            (cond
              [(empty? loib) empty]
              [(cons? loib)
               (local
                 ( ;;;; Signature
                  ;; move-invader-bullet: InvaderBullet -> InvaderBullet
                  ;;;; Purpose
                  ;; GIVEN: an invader bullet
                  ;; RETURNS: the invader bullet after downwarded by
                  ;;          BULLET-SPEED
                  (define (move-invader-bullet ib)
                    (make-posn (posn-x ib)
                               (+ (posn-y ib) BULLET-SPEED))))
                 (map move-invader-bullet loib))]))


          ;;;; Signature
          ;; invaders-fire: List<Invader> List<IB> TickNumber -> List<IB>
          ;;;; Purpose
          ;; GIVEN: all invaders, a list of invader bullets and the clock tick
          ;;        number from last invader move in the current game 
          ;; RETURNS: the updated list of invader bullets with all the newly
          ;;          fired bullets added
          (define (invaders-fire loi loib t)
            (local
              (;;;; Signature
               ;; invader-fire: Invader LoIB -> LoIB
               ;;;; Purpose
               ;; GIVEN: an invader, a list of invader bullets 
               ;; RETURNS: the updated list of invader bullets with the newly
               ;;          fired bullet added if the number of invader bullets
               ;;          in the list is under INVADER-BULLET-LIMIT, otherwise
               ;;          the current list of invader bullets
               (define (invader-fire iv loib)
                 (cond
                   [(< (length loib) INVADER-BULLET-LIMIT)
                    (cond
                      [(< (random RANDOM-RANGE) FIRE-CAP)
                       (local (;;;; Signature
                               ;; new-invader-bullet:
                               ;; Invader -> InvaderBullet
                               ;;;; Purpose
                               ;; Given: an invader  
                               ;; RETURNS: an InvenderBullet just fired from
                               ;;          the given invader 
                               (define (new-invader-bullet iv)
                                 (cond
                                   [(>= t INVADER-MOVE-TICK)
                                    (make-posn (posn-x iv)
                                               (+ (posn-y iv)
                                                  INVADER-SIDE
                                                  (/ BULLET-SIDE 2)))]
                                   [else (make-posn
                                          (posn-x iv)
                                          (+ (posn-y iv)
                                             (/ INVADER-SIDE 2)
                                             (/ BULLET-SIDE 2)))])))
                         (cons (new-invader-bullet iv) loib))]
                      [else loib])]
                   [else loib])))
              (foldr invader-fire loib loi))))

         (remove-hits-out-of-bounds-and-update-score
          (make-world
           (move-spaceship (world-spaceship w))
           (move-invaders (world-loi w) (world-tick w))
           (move-spaceship-bullets (world-losb w))
           (move-invader-bullets (invaders-fire (world-loi w)
                                                (world-loib w)
                                                (world-tick w)))
           (world-score w)
           (world-life w)
           (local (;;;; Signature
                   ;; update-tick: TickNumber -> TickNumber
                   ;;;; Purpose
                   ;; GIVEN: the number of clock ticks from the last invader
                   ;;        move
                   ;; RETURNS: the updated clock tick number after one clock
                   ;;          tick
                   (define (update-tick t)
                     (cond
                       [(< t INVADER-MOVE-TICK)
                        (+ TICK-INCREMENT t)]
                       [else TICK-INIT])))
             (update-tick (world-tick w))))))))
    (update-life  (pre-world-step w))))





;;;; Signature
;; key-handler: World Key-Event -> World
;;;; Purpose
;; GIVEN: the current world and a key event
;; RETURNS: a new world with spaceship direction updated or spaceship bullet
;;          fired according to the key event
(define (key-handler w ke)
  (cond
    [(or (key=? ke "left")
         (key=? ke "right"))
     (local (;;;; Signature
             ;; change-direction: Spaceship Key-Event -> Spaceship
             ;;;; Purpose
             ;; GIVEN: a spaceship and a key event
             ;; RETURNS: a new spaceship with the direction changed according
             ;;          to the key event
             ;;;; Function Definition
             (define (change-direction sp ke)
               (cond
                 [(or (key=? "left" ke)
                      (key=? "right" ke))
                  (make-spaceship (string->symbol ke)
                                  (spaceship-location-x sp))]
                 [else sp])))
       (make-world (change-direction (world-spaceship w) ke)
                   (world-loi w)
                   (world-losb w)
                   (world-loib w)
                   (world-score w)
                   (world-life w)
                   (world-tick w)))]
    [(key=? ke " ")
     (make-world (world-spaceship w)
                 (world-loi w)
                 (local (;;;; Signature 
                         ;; spaceship-fire: Spaceship List<SB> -> List<SB>
                         ;;;; Purpose
                         ;; GIVEN: a spaceship  and a list of spaceship bullets
                         ;; RETURNS: the updated list of spaceship bullets with
                         ;;          one bullet fired by the spcaeship added if
                         ;;          the number of spaceship bullets in the
                         ;;          current game is less than 3, the given
                         ;;          list of spacesehip bullets otherwise
                         ;;;; Function Definition
                         (define (spaceship-fire sp losb)
                           (cond
                             [(< (length losb) SPACESHIP-BULLET-LIMIT)
                              (cons (make-posn (spaceship-location-x sp)
                                               (- SPACESHIP-Y
                                                  (/ SPACESHIP-HEIGHT 2)
                                                  (/ BULLET-SIDE 2)))
                                    losb)]
                             [else losb])))
                   (spaceship-fire (world-spaceship w) (world-losb w)))
                 (world-loib w)
                 (world-score w)
                 (world-life w)
                 (world-tick w))]
    [else w]))




          
;;;; Signature
;; end-game? World -> Boolean
;;;; Purpose
;; GIVEN: the current world
;; RETURNS: true if the condition that end the game has been met,
;;          false otherwise
;;;; Function Definition
(define (end-game? w)
  (or (empty? (first (world-loi w)))
      (= 0 (world-life w))
      (local (;;;; Signature
              ;; lowest-invader-y: List<Invader> -> Number
              ;;;; Purpose
              ;; GIVEN: all invaders in the current game
              ;; RETURNS: the y-coordinate of the lowest invader
              ;;;; Function Definition
              (define (lowest-invader-y loi)
                (argmax (λ (x) (posn-y x)) loi)))
        (<= SPACESHIP-Y (posn-y (lowest-invader-y (world-loi w)))))))



  


(big-bang WORLD-INIT
          (to-draw world-draw)
          (on-tick world-step 0.1)
          (on-key key-handler)
          (stop-when end-game?))

















  


    











                      




                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     













