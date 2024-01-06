(define (windchill W F)
  (let ((sqw (sqrt w)))
    (+ 1.05 (* 0.93 F) (* -3.65 W) (* 3.62 sqw)
       (* 0.103 F sqw) (* 0.0439 W W))))

(define (pressure h)
  (let ((p0 101325)
        (L 0.0065)
        (T0 288.15)
        (g 9.80665)
        (M 0.0289644)
        (R 8.31447))
    (* p0 (expt (- 1 (/ (* L h) T0)) (/ (* g M) (* R L))))))

(define (compose f g)
  (lambda (x) (f (g x))))

(define (repeated f n)
  (if (= n 1) f
      (compose f (repeated f (- n 1)))))