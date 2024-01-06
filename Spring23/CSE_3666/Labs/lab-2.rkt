"Problem 1"
(define (geom-series-np2 n)
  (if (= n 0) 1
      (+ (/ 1 (expt 2 n))
        (geom-series-np2 (- n 1)))))

(geom-series-np2 2)

"Problem 2"
(define (zeroexpt n)
  (if (= n 0) 0
      (+ 1
         (zeroexpt
          (/ (- n (modulo n 10)) 10)))))

(define (num-digits n)
  (if (= (zeroexpt n) 0) 1 (zeroexpt n))) 

"Problem 3"
"3a"
(define (a n)
  (if (= n 0) 1
      (* 2 (a (- n 1)))))

"3b"
(define (num-ancestors n)
  (if (= n 0) 0
      (+ (a n) (num-ancestors (- n 1)))))


"Problem 4"
(define (n-term n k)
  (if (or (< n k) (< k 0)) 0
      (if (= k 0) 1 
      (* n (n-term (- n 1) (- k 1))))))


(define (k-term k)
  (if (<= k 0) 1
      (* k (k-term (- k 1)))))

(define (n-choose-k n k)
  (/ (n-term n k) (k-term k)))

"Problem 5"
(define (pascals-triangle n k)
  (if (or (< k 0) (< n k)) 0
          (if (and (= n 0) (= k 0)) 1
                   (+ (pascals-triangle (- n 1) k)
                      (pascals-triangle (- n 1) (- k 1))))))
