"Problem 1"
"a"
(define (c->p p)
  (cons (sqrt (+ (* (car p) (car p))
                 (* (cdr p) (cdr p))))
        (atan (/ (cdr p) (car P)))
        ))

"b"
(define (p->c p)
  (cons (* (car p) (cos (cdr p)))
        (* (car p) (sin (cdr p)))
        ))

"Problem 2"
(define (y p1 p2)
  (let* ((m (/ (- (cdr p2) (cdr p1))
               (- (car p2) (car p1))))
        (b (+ (* m (- (car p2) (car p1)))
              (cdr p1) (* -1 m (car p2)))))
    (lambda (x)
      (+ (* x m) b))
    ))

"Problem 3"
(define (hamming-weight lst)
  (cond ((null? lst) 0)
        ((= (car lst) 0) (hamming-weight (cdr lst)))
        (else (+ 1 (hamming-weight (cdr lst))))
        ))

"Problem 4"
(define (hamming-distance L1 L2)
  (cond ((null? L1) 0)
        ((= (car L1) (car L2)) (hamming-distance (cdr L1) (cdr L2)))
        (else (+ 1 (hamming-distance (cdr L1) (cdr L2))))
        )) 

"Problem 5"
(define (sv-mult l v)
  (if (null? l) '()
      (cons (* v (car l))
            (sv-mult (cdr l) v))
      ))

"Problem 6"
(define (v-add L1 L2)
  (if (null? L1) '()
      (cons (+ (car L1) (car L2))
            (v-add (cdr L1) (cdr L2)))
      ))

"Problem 7"
 (define (dot L1 L2)
  (if (null? L1) 0
      (+ (* (car L1) (car L2)) (dot (cdr L1) (cdr L2)))))