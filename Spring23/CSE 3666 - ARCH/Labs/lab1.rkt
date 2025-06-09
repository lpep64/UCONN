"Problem 1"
"problem 1a."
(define (usd-to-euro x)
  (* x 0.82))
"tests"
"$250 USD to Euros"
(usd-to-euro 250)
"problem 1b."
(define (euro-to-yen x)
  (* x 126.01))
"tests"
"€250 Euro to Yen"
(euro-to-yen 250)
"problem 1c."
(define (usd-to-yen x)
  (euro-to-yen(usd-to-euro x)))
"tests"
"$250 USD to Yen"
 (usd-to-yen 250)
"Problem 2"
"problem 2a."
(define e 2.71828)
"tests"
e
"problem 2b."
"tests"
(define (tanh x)
  (/
   (-(expt e
           (* 2 x)
           ) 1)
   (+(expt e
           (* 2 x)
           ) 1)))
"tanh(1)"
(tanh 1)
"Problem 3"
"problem 3a."
(define (det2x2 a b c d)
  (-
   (* a d)
   (* b c)
   ))
"tests"
"2  -4"
"-6 12"
(det2x2 2 -4 -6 12)
"problem 3b."
(define (invertible? a b c d)
  (not (= 0 (det2x2 a b c d))))
"tests"
(invertible? 2 -4 -6 12)
(invertible? -3 1 2 7)
(invertible? 1 1 1 1)
"problem 3ci."
"no tests"
(define (prod-inv-direct? a1 b1 c1 d1 a2 b2 c2 d2)
  (invertible? (+(* a1 a2) (* b1 c2))
               (+(* a1 b2) (* b1 d2))
               (+(* c1 a2) (* d1 c2))
               (+(* c1 b2) (* d1 d2)) ))
"problem 3cii."
(define (prod-inv-indirect? a1 b1 c1 d1 a2 b2 c2 d2)
  (not (= 0 (* (det2x2 a1 b1 c1 d1) (det2x2 a2 b2 c2 d2)))))

(prod-inv-indirect? 2 -4 -6 12 -3 1 2 7)
(prod-inv-indirect? -3 1 2 7 -3 1 2 7)
(prod-inv-indirect?  1 0 0 1 0 1 1 0)
(prod-inv-indirect? 0 -1 -1 0  1 1 1 1)

