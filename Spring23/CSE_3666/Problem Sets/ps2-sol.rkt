"Problem 1"
(define (fizzbuzz x)
  (if
   (and (= 0 (modulo x 3))
        (= 0 (modulo x 5)))
   "fizzbuzz"
   (if (= 0 (modulo x 3)) "fizz"
          (if (= 0 (modulo x 5)) "buzz" x))))

(define (fizz x)
  (if (= 0 (modulo x 3)) "fizz" ""))

(define (buzz x)
  (if (= 0 (modulo x 5)) "buzz" ""))

(define (fizzbuzz2 x)
  (if
   (equal? (string-append (fizz x) (buzz x)) "")
   x
   (string-append (fizz x) (buzz x)))
  )

"Problem 2"
(define (piecewise x)
  (if (> x (* 2 3.142)) (- x (* 2 3.142))
      (if (or (<= -3.142 x) (<= x (* 2 3.142))) (sin x) (- (- 0 x) 3.142))))

"Problem 3"
(define (inc x) (+ x 1))
(define (dec x) (- x 1))

(define (add n m)
  (if (= n 0) m
      (add (dec n) (inc m))))

"Problem 4"
(define (mult n m)
  (if (= n 0) 0
      (add m (mult (dec n) m))))

"Problem 5"
(define (power b n)
  (if (= n 0) 1
      (mult (power b (dec n)) b)))

"Problem 6"
(define (raise x n)
  (if(= n 0) 1
     (if (= 0 (modulo n 2))
         (raise (mult x x)(/ n 2))
         (mult x (raise(mult x x)
                       (floor(/ n 2)))))))

"Problem 7"
(define (pmult x y)
  (cond((= x 0) 0)
       ((= y 0) 0)
       ((> x 1)
        (if (= (modulo x 2) 0)
            (pmult (floor (/ x 2)) (* y 2))
            (+ y (pmult (floor (/ x 2)) (* y 2)))))
       ((= x 1) y)
       (y)))

"Problem 8"
(define (sumEven n)
  (if (<= n 0) 0
                (if (= (modulo n 2) 0)
                    (+ n (sumEven (- n 2)))
                                  (sumEven (- n 1 )))))

(define (sumOdd n)
  (cond ((= n 0) 0)
        ((= (modulo n 2) 1)
        (+ n (sumOdd (- n 1))))
        ((= (modulo n 2) 0)
         (sumOdd (- n 1)))
        (n)))

"Problem 9"
(define (h-product k)
  (if (= k 1) 1
      (* (- 1 (/ 1 k)) (h-product (- k 1)))))

"Problem 10"
(define (divides a b) (= 0 (modulo b a)))

(define (divisors n)
  (divisors-upto n n))

(define (divisors-upto n k)
  (cond ((= k 0) 0)
        ((= n 0) 0)
        ((= k 1) 1)
        ((= (modulo n k) 0) (+ 1 (divisors-upto n (- k 1))))
        (else (divisors-upto n (- k 1)))))

"Problem 11"
(define (subfact n)
  (cond ((= n 0) 1)
        ((= n 1) 0)
        ((> n 1) (* (- n 1) (+ (subfact (- n 1)) (subfact (- n 2)))))))


"Problem 12"
(define (new-cos x n)
   (define (factorial n)
        (if (= n 0)
            1
            (* n (factorial (- n 1)))))
    (if (= n 0)
        1
        (+ (new-cos x (- n 1)) 
           (/ (* (expt -1.0 n) (expt x (* 2 n))) (factorial (* 2 n))))))