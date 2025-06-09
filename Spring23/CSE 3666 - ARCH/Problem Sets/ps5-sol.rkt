(define pledge "I confirm that my submitted solutions are the
result of my own intellectual effort, and comply with the 1729 honor code
and the UConn standards for academic integrity")

"Problem 1"
(define (splice f g)
  (define (stepper x)
    (- (* 3 (expt x 2))
       (* 2 (expt x 3))))
  (lambda (x)
    (cond ((< x 0) (f x))
          ((> x 1) (g x))
          (else (+ (* (stepper x) (g x))
                   (* (- 1 (stepper x)) (f x)))))))

"Problem 2"
(define (nlength xyz)
  (if (null? xyz) 0
      (+ 1 (nlength (cdr xyz)))))

(define (zip a b)
  (if (not(= (nlength a) (nlength b))) 0
      (if (null? a) '()
          (cons (cons (car a) (car b))
                      (zip (cdr a) (cdr b))))))

"Problem 3"
(define (unzip c)
  (if (null? c) '(() . ())
      (let* ((d (unzip (cdr c)))
             (1st (car d))
             (2nd (cdr d)))
        (cons (cons (caar c) 1st)
              (cons (cdar c) 2nd)))))

"Problem 4"
(define (change n l)
  (cond ((< n 0) 0)
        ((= n 0) 1)
        ((null? l ) 0)
        (else (+ (change n (cdr l))
                  (change (- n (car l)) l)))))

"Problem 5"
"a"
(define (encode e)
  (let ((sum (+ (car e) (cdr e))))
    (+ (* sum (+ sum 1) (/ 1 2)) (cdr e))))

"b"
(define (decode a)
  (let* ((b (floor (/ (- ( sqrt (+ (* 8 a ) 1)) 1) 2)))
         (c (/ (+ (* b b) b) 2))
         (d (- a c))
         (e (- b d)))
    (cons e d)))

"Problem 6"
(define (positives n)
  (cond ((null? n) '() )
        ((<= (car n) 0)(positives (cdr n)))
        (else (cons (car n) (positives (cdr n))))))

"Problem 7"
(define (remove-duplicates n)
  (define (remove r e)
    (cond ((null? e) '() )
          ((= r (car e)) (remove r (cdr e)))
          (else (cons (car e) (remove r (cdr e))))))
  (if (null? n) '()
      (cons (car n) (remove (car n) (remove-duplicates (cdr n))))))





