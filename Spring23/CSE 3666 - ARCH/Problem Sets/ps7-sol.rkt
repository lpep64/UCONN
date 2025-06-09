"Problem 1"
(define (merge a b)
  (cond ((null? a) b)
        ((null? b) a)
        ((< (car a) (car b)) 
        (cons (car a) (merge (cdr a) b)))
        (else
        (cons (car b) (merge a (cdr b))))))

"Problem 2"
(define (ones l)
	(if (null? l) '()
		(if (null? (cdr l)) (list (car l))
			(cons (car l) (ones (cddr l))))))
(define (twos l)
	(if (null? l) '()
		(if (null? (cdr l)) '()
			(cons (cadr l) (twos (cddr l))))))

(define (mergehelp l)
	(cons (ones l) (cons (twos l) `())))

(define (mergesort l)
	(if (null? l) l
		(if (null? (cdr l)) l
			(merge
				(mergesort (car (mergehelp l)))
				(mergesort (cadr (mergehelp l)))))))

"Question 3"
(define (ins x l)
  (if (null? l) (list x)
      (if (< x (car l))
          (cons x l)
          (cons (car l) (ins x (cdr l))))))

"Question 4"
(define (insSort l)
  (if (null? l) '()
    (insert (car l) (insSort (cdr l)))))

(define (insert x l)
  (cond
    ((null? l) (list x))
    ((< x (car l)) (cons x l))
    (#t (cons (car l) (insert x (cdr l))))))


"Problem 5"
(define (accumulate op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))

(define (fold-right op initial sequence)
  (if (null? sequence)
    initial
    (op (car sequence)
        (accumulate op initial (cdr sequence)))))



"5a."
(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

"5b."
(define (my-map p sequence)
  (accumulate (lambda (x y) (cons (p x) y))
              '()
              sequence))

"5c."
(define (my-append seq1 seq2)
  (accumulate cons seq2 seq1))

"5d."
(define (my-length sequence)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequence))

"5f."
(define (reverse-r sequence)
    (fold-right (lambda (x y) (append y (list x))) '() sequence))

"5g."
(define (reverse-l sequence)
    (fold-left (lambda (x y) (cons y x)) '() sequence))

"5h."
(define (horner-eval x coefficient-list)
    (accumulate (lambda (this-coeff higher-terms)
                        (+ this-coeff
                           (* higher-terms x)))
                0
                coefficient-list))

"Problem 6"
"6a."
"i"
(define (left-truncatable-prime? p)
  (if (prime? p) (if (= (left-shrink p) 0) #t (left-truncatable-prime? (left-shrink p))) 
      #f)
     )
 
(define (primehelp x k)
  (if (= x k) #t
  (if (= (modulo x k) 0) #f
      (primehelp x (+ k 1)))))

(define (prime? x )
    (cond
      (( = x 1 ) #f)
      (( = x 2 ) #t)
      (else (primehelp x 2 ) )))
  
(define (left-shrink p)
  (if (null? (numlist p)) 0
      (listnum (cdr (numlist p)))))

(define (listnum l)
  (let loop ((t 0) (l l))
    (if (null? l)
        t
        (loop (+ (* 10 t) (car l)) (cdr l)))))
            
(define (numlisthelp n lst)
  (cond ((< n 10) (cons n lst))
        (else (numlisthelp (floor (/ n 10)) (cons (modulo n 10) lst)))))

(define (numlist n)
  (numlisthelp n '()))

"ii"
(define (nth-left-trunc-prime n)
  (nth-left 0 0 n)
)

(define (nth-left a c n)
  (if (= a n) (- c 1)
      (if (= c 106) (nth-left (- a 1) (+ 2 c) n)
      (if (left-truncatable-prime? c)
          (nth-left (+ a 1) (+ 1 c) n)
          (nth-left a (+ 1 c) n)
          )
      )
      )
  )
(nth-left-trunc-prime 17)
"6b."
"i"
(define (right-truncatable-prime? p)
  (if (prime? p) (if (= (right-shrink p) 0) #t (right-truncatable-prime? (right-shrink p))) 
      #f)
     )

(define (right-shrink p)
  (if (null? (numlist p)) 0
      (listnum (reverse (cdr (reverse (numlist p)))))))

"ii"
(define (nth-right-trunc-prime n)
  (nth-right 0 0 n)
)

(define (nth-right a c n)
  (if (= a n) (- c 1)
      (if (right-truncatable-prime? c)
          (nth-right (+ a 1) (+ 1 c) n)
          (nth-right a (+ 1 c) n)
          )
      )
  )


"6c."
"i"
(define (two-sided-prime? p)
  (if (and (left-truncatable-prime? p) (right-truncatable-prime? p)) #t #f
      )
     )

"ii"
(define (nth-two-sided-prime n)
  (nth-two 0 0 n)
)

(define (nth-two a c n)
  (if (= a n) (- c 1)
      (if (two-sided-prime? c)
          (nth-two (+ a 1) (+ 1 c) n)
          (nth-two a (+ 1 c) n)
          )
      )
  )



