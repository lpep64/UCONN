"Problem 1"
(define (pell n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (* 2 (pell (- n 1))) (pell (- n 2))))))

(define (find-pell n)
  (define (f-p-pell x n)
    (if (> (pell x) n)
        (pell (- x 1))
        (help (+ x 1) n)))
  (help 0 n))
        
(define (comp-pell n)
  (cond ((= n 0) 2)
        ((= n 1) 2)
        (else (+ (* 2 (comp-pell (- n 1))) (comp-pell (- n 2))))))

(define (sqrt-2-approx n)
  (/ (/ (comp-pell n) 2) (pell n)))


"Problem 2"

(define (viete n)
  (if (= n 0) 0
      (call-viete n)))

(define (call-viete n)
  (if (= n 0) 1
      (* (/ (square-root-nest n) 2) (call-viete (- n 1)))))

(define (square-root-nest n)
  (if (= n 0) 0
      (sqrt (+ 2 (square-root-nest (- n 1))))))

"Problem 3"
(define (new-sqrt x n)
  (cond ((= x 1) 1)
        ((= n 0) 1)
        (else (+ 1 (/ (- x 1) (rep-sqrt x n))))))

(define (rep-sqrt x n)
  (if (= n -2) 1
        (+ 2 (/ (- x 1) (rep-sqrt x (- n 1))))))

(new-sqrt 5 2)
"Problem 4"
(define (m91 n)
  (if (> n 100) (- n 10)
      (m91 (m91 (+ n 11)))))

"Problem 5"
(define (iradius A B C)
  (let ((S (/ (+ A B C) 2)))
  (sqrt (/ (* (- S A) (- S B) (- S C)) S))))

"Problem 6"
(define (heron a b c)
  (let ((s (* (/ 1 2) (+ a b c))))
    (let ((sa (- s a)))
      (let ((sb (- s b)))
        (let ((sc (- s c)))
          (sqrt (* s sa sb sc)))))))