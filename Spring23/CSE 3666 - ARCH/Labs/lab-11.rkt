"Problem 1"
"a."
(define (head s) (car s))

(define (rest s) (force (cdr s)))

(define (lucas-stream)
  (define (lucas-stream-helper current next)
    (cons current (delay (lucas-stream-helper next (+ next current)))))
  (lucas-stream-helper 1 3))

"b."
(define (lucas-pseudoprime i)
  (define (lucas k l)
    (if (= k 1)
        (head l)
        (lucas (- k 1) (rest l))))
  (let ((ith-lucas (lucas i (lucas-stream))))
    (= (modulo (- ith-lucas 1) i ) 0)))

"Problem 2"
"a."
(define (ll-stream)
  (define (ll-stream-helper i)
    (cons i (delay (ll-stream-helper (- (* i i) 2)))))
  (ll-stream-helper 4))

"b."
(define (ll-test-stream p)
  (define (square x) (* x x))
  (define ( ll-test-helper s)
    (cons s (delay (ll-test-helper (modulo (- (square s) 2) p)))))
(ll-test-helper 4))

"Problem 3"
(define (mprime? p)
  (define (ll-helper l-stream i)
    (if (= i 2)
        (= (head l-stream) 0)
        (ll-helper (rest l-stream) (- i 1))))
  (ll-helper (ll-test-stream (- (expt 2 p) 1)) p))