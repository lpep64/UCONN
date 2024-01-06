"Problem 1"
(define (harmonic n)
  (if (= n 1) 1
      (+ (/ 1.0 n) (harmonic (- n 1)))))

(define (Eulerest n)
  (if (> 0  (- (harmonic n) (log n)))
      (* (- (harmonic n) (log n)) -1.0)
      (- (harmonic n) (log n))))

"Problem 2"
(define (prime? n)
  (define (divisor? k) (= 0 (modulo n k)))
  (define (divisors-upto k)
    (and (> k 1)
         (or (divisor? k) (divisors-upto (- k 1)))))
  (not (divisors-upto (- n 1))))

(define (count-primes t)
  (cond ((= t 1) 0)
        ((prime? t) (+ 1 (count-primes (- t 1))))
        (else (count-primes (- t 1)))))

"Problem 3"
(define (rel-prime a b)
  (define (divides-both d)
    (and (= 0 (modulo a d))
         (= 0 (modulo b d))))
  (define (divisor-upto k)
    (and (> k 1)
         (or (divides-both k)
             (divisor-upto (- k 1)))))
  (not (divisor-upto (min a b))))

(define (count-rel-prime n)
  (define (count-rel a b)
    (define (count a b)
      (if (= b 0) 0
          (if (rel-prime a b) (+ 1 (count a (- b 1)))
              (helper2 a (- b 1)))))
    (if (= b 0) 0
        (+ (count a b) (count-rel (- a 1) (- b 1)))))
  (count-rel n n))

"Problem 4"
(define (lucas n)
   (cond ((= n 0) 2)
         ((= n 1) 1)
         ((> n 1) (+ (lucas (- n 1)) (lucas (- n 2))))))

(define (Lucas-ratio n)
  (/ (lucas n) (lucas (- n 1))))

(define (fib n)
   (cond ((= n 0) 0)
         ((= n 1) 1)
         ((> n 1) (+ (fib (- n 1)) (fib (- n 2 ))))))

(define (Fibonacci-ratio n)
   (/ (fib n) (fib (- n 1))))

(define (fast-lucas n)
  (fast-lucas-help n 1 1 2))

(define (fast-lucas-help n k lucas-a lucas-b)
  (if (= n k ) lucas-a
      (fast-lucas-help n (+ k 1) (+ lucas-a lucas-b) lucas-a)))

(define (rec-call-lucas k)
    (cond ((= k 1)  0)
          ((= k 2)  2)
          ((= k 3)  4)
          ((= k 4)  8)
          ((= k 5)  14)
          ((= k 6)  24)
    ))

;; Do the same for the fast-lucas-helper
(define (rec-call-fast-lucas-helper k)
    (- k 1))

  
"Problem 5"
(define (golden n)
  (if (= n 1) 2
      (+ 1 (/ 1 (golden (- n 1))))))

(define (golden-sqrt n)
  (if (= n 0) 1
      (sqrt (+ 1 (golden-sqrt (- n 1))))))

"Problem 6"
(define (explain-interval-sum)
  (define d "The predicate to recognize the base case is wrong. One can go from m > n to m < n without ever seeing n = m.")
  d)

"Problem 7"
(define (ack m n)
  (cond ((= m 0) (+ n 1))
        ((and (> m 0) (= n 0)) (ack (- m 1) 1))
        ((and (> m 0) (> n 0)) (ack (- m 1) (ack m (- n 1))))
        ))

"Problem 8"
(define (catalan n)
  (define (cata k)
    (/ (+ n k) k))
  (define (helper s f)
    (cond ((> s n) f)
          ((or (= s 0)
               (= s 1)) (helper (+ 1 s) f))
          (else (helper (+ 1 s) (* f (cata s))))))
  (helper 0 1))
  
"Problem 9"
(define pi-approx
  (let ((a (* 0.5 (+ 23 (* 4 (sqrt 34)))))
        (b (* 0.5 (+ (* 19 (sqrt 2)) (* 7 (sqrt 17)))))
        (c (+ 429 (* 304 (sqrt 2))))
        (d (* 0.5 (+ 627 (* 442 (sqrt 2))))))
          (let ((u
                 (* (expt (+ a (sqrt (+ (* a a) -1))) 2)
                    (expt (+ b (sqrt (+ (* b b) -1))) 2)
                    (+ c (sqrt (+ (* c c) -1)))
                    (+ d (sqrt (+ (* d d) -1))))
                 ))
            (/ (log (+ (expt (* 2 u) 6) 24)) (sqrt 3502)))))           
(+ 0 pi-approx)


"Problem 10"
(define (gauss-legendre tol)
  (define (square x) (* x x))
  (define (help a b t p)
    (let ((an (/ (+ a b) 2))
          (bn (sqrt (* a b)))
          (tn (- t (* p (square (- a (/ (+ a b) 2))))))
          (pn (* 2 p)))
      (if (< (abs (- an bn)) tol)
          (/ (square (+ an bn)) (* 4 tn))
          (help an bn tn pn))))
  (help 1 (/ 1 (sqrt 2)) (/ 1 4) 1))
          

              







   
