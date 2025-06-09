(* (+ 22 42) (* 54 99))
(* (* (+ 22 42) 54) 99)
(+ (* 64 102) (* 16 (/ 44 22)))
(define limerick (+ (/ (+ 12 144 20 (* 3 (sqrt 4))) 7) (* 5 11)))

(define (inc x)
  (+ x 1))

(define (inc2 x)
  (define once (inc x))
  (inc once))

(define (cube x)
  (* x x x))

(define (p x)
  (define twice (+ (* x x x x x) (* 16 x x x x) (* 22 x x x) x 9))
  (* twice twice))

(define (ninth x)
  (* x x x x x x x x x ))

(define (eighty-first x)
  (ninth (ninth x)))

(define (isbn10-checkdigit x10 x9 x8 x7 x6 x5 x4 x3 x2)
    (modulo (- 11 (modulo (+ (* 10 x10) (* 9 x9) (* 8 x8) (* 7 x7) (* 6 x6) (* 5 x5) (* 4 x4) (* 3 x3) (* 2 x2)) 11)) 11))

(define (is-isbn10? x10 x9 x8 x7 x6 x5 x4 x3 x2 x1)
  (zero? (modulo (- 11 (modulo (+ (* 10 x10) (* 9 x9) (* 8 x8) (* 7 x7) (* 6 x6) (* 5 x5) (* 4 x4) (* 3 x3) (* 2 x2) x1) 11)) 11)))

(define (fspiral theta)
  (expt 1.618 (* theta (/ 2 3.142))))

(define (root1 a b c)
  (/(+ (* -1 b) (sqrt (- (expt b 2) (* 4 a c)))) (* 2 a)))

(define (root2 a b c)
  (/(- (* -1 b) (sqrt (- (expt b 2) (* 4 a c)))) (* 2 a)))

(define (number-of-roots a b c)
  (if (= (root1 a b c) (root2 a b c)) 1 2))

(define (real-roots? a b c)
 (and (real? (root1 a b c)) (real? (root2 a b c))))

(number-of-roots 1 2 4)