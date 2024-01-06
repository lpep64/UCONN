"Problem 1"
(define (nlength xyz)
  (if (null? xyz) 0
      (+ 1 (nlength (cdr xyz)))))

(define (zip a b)
  (if (not (= (nlength a) (nlength b))) 0
      (if (null? a) '()
          (cons (cons (car a) (car b))
                      (zip (cdr a) (cdr b))))))

"Problem 2"
(define (unzip c)
  (if (null? c) '(() . ())
      (let* ((d (unzip (cdr c)))
             (1st (car d))
             (2nd (cdr d)))
        (cons (cons (caar c) 1st)
              (cons (cdar c) 2nd)))))

"Problem 3"
(define (change k l)
  (cond ((= k 0) 1)
        ((or (< k 0) (null? l)) 0)
        (else
         (+ (change k (cdr l))
            (change (- k (car l)) l)))))

"Problem 4"
(define (cha-help n cur)
  (cond ((null? cur) '())
        (else (cons (append (car cur) (list n))
                    (cha-help n (cdr cur))))
        ))

(define (make-change n den)
  (cond ((< n 0) '())
        ((= n 0) '(()))
        ((null? den) '())
        (else (append (make-change n (cdr den))
                      (cha-help (car den) (make-change (- n (car den)) den))
                      ))
        ))

"Problem 5"
(define (relper coins n)
    (if (null? coins) coins
        (if (null? (cdr coins)) (list (cons n (car coins)))
            (if (= (car coins) (car (cdr coins))) 
                (relper (cdr coins) (+ n 1))
                (cons (cons n (car coins)) (relper (cdr coins) 1))
            )
        )
    )
)
(define (rle coins)
    (relper coins 1)
)

      
"Problem 7"
"a"
(define (list-sum L)
  (if (null? L) 0
      (+ (car L) (list-sum (cdr L)))
      ))
"b"
(define (average L)
  (/ (list-sum L) (nlength L)))

"c"
(define (var-map L)
  (define (square X)
    (* X X))
  (let ((mean (average L)))
    (map (lambda (X) (square (- X mean))) L ))
  )

"d"
(define (stdev L)
  (sqrt (average (var-map L))))

"e"
(define (map2 c L K)
  (if (null? L) '()
      (cons (c (car L) (car K))
            (map2 c (cdr L) (cdr K)))
      ))

"f"
(define (covar-elements L K)
  (let ((meanL (average L))
        (meanK (average K)))
    (map2 (lambda (l k) (* (- l meanL ) (- k meanK))) L K)
    ))

"g"
(define (pearson L K)
   (/ (average (covar-elements L K))(* (stdev L) (stdev K))))

"Problem 8"
"a"
(define (best-fit L K)
  (let* ((a (* (pearson L K)
                   (stdev K) (/ 1 (stdev L))))
         (b (- (average K) (* a (average L))))
         )
       (cons a b)))

"b"
(define (best-fit-fn pX pY )
  (let* ((a (* (pearson pX pY)
                   (stdev pY) (/ 1 (stdev pX))))
         (b (- (average pY) (* a (average pX))))
         )
    (lambda (x) (+ (* a x) b ))))