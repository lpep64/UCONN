"Problem 1"
(define (sum term a next b)
  (if (> a b) 0
      (+ (term a)
         (sum term (next a) next b))))

(define (harmonic n)
  (sum
   (lambda (x) (/ 1 x)) 1
   (lambda (y) (+ 1 Y)) n))

"Problem 2"
"a."
(define (product term a next b)
    (if (> a b) 1
        (* (term a)
           (product term (next a) next b))))
"b."


"Question 3"
(define (frac-sum-help f g n m)
  (cond ((< m n) 0)
        ((= 0 (g n)) (frac-sum-help f g (+ n 1) m))
        (else (+ (/ (f n) (g n))
                 (frac-sum-help f g (+ n 1) m )))))

(define (frac-sum f g n) (frac-sum-help f g (- n) n))

"Question 4"
"a"
(define (der f h)
  (define (return x)
    (/ (- (f (+ x h)) (f x))
       h))
  return)

"b"
(define (der-n f n h)
  (if (= n 0) f
      (der-n (der f h) (- n 1) h)))

"Question 5"
(define (newton f x n)
  (define Df (der f .01))
  (define (newton-iter x k)
    (let ((new-x (- x
                    (/ (f x) (Df x )))))
      (if (= k 0) x
          (newton-iter new-x (- k 1)))))
  (newton-iter x n))

(define (p x) (- (* x x x) 100))
(define start 2.0)
(newton p start 2)
(newton p start 4)
(newton p start 8)
(newton p start 16)
(newton p start 32)
(define (g x) (+ (* x x) (- x) -1))
(newton g start 2)
(newton g start 4)
(newton g start 8)
(newton g start 16)
(newton g start 32)
(define (sqrt-newt n)
(define (p x) (- (* x x) n))
(newton p 1 40))

(sqrt-newt 10)
(sqrt-newt 100000)

"Question 6"
(define (sum-term term a b)
  (if (> a b) 0
      (+ (term a) (sum-term term (+ a 1) b))))
(define (simpson-integrate f a b n)
  (let ((h (/ (- b a) n)))
    (define (even x) (= ( modulo x 2) 0))
    (define (odd x) (not (even x)))
    (define (y k)
      (f (+ a (* k h))))
    (define (s-term k)
      (cond ((= k 0) (y k))
            ((= k n) (y k))
            (( even k) (* 2 (y k)))
            (( odd k) (* 4 (y k )))))
    (* (/ h 3) ( sum-term s-term 0 n))))
