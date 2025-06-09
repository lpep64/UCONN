"1."
(define (get-count text)
  (define (T-update char T)
    (cond ((null? T) (cons (cons char 1) T))
          ((eq? char (caar T)) (cons (cons (caar T) (+ 1 (cdr (car T)))) (cdr T)))
          (else (cons (car T) (T-update char (cdr T))))))
  (define (s-list char)
    (cond ((null? char) '())
          (else (T-update (car char) (s-list (cdr char))))))
  (s-list (string->list text)))

"2."
(define (get-freq list-count)
  (define (list-sum the-list)
    (cond ((null? the-list) 0)
          (else (+ (cdr (car the-list))
                   (list-sum (cdr the-list))))))
  (define (div-recursion the-list len)
    (cond ((null? the-list) '())
          (else (cons (cons (caar the-list) (/ (cdr (car the-list))
                                               len)) (div-recursion (cdr the-list) len)))))
  (div-recursion list-count (list-sum list-count)))

"3."
(define (htree-leaf letter weight)
  (list 'leaf weight letter))

(define (htree-node t0 t1)
  (list 'internal (+ (htree-weight t0)
                     (htree-weight t1)) t0 t1))

(define (htree-weight t) (cadr t))

(define (huffman freqs)
  (process (convert freqs)))

(define (compare t0 t1)
  (if (< (htree-weight t0) (htree-weight t1)) t0
      t1))

(define (findMin l)
  (cond ((null? (cdr l))l)
        (else    (let* ((rest (findMin (cdr l)))
               (smallest (car rest))
               (tail (cdr rest))
               (head (car l))
               (win (compare smallest head))
               (lose (if (eq? win smallest) head smallest)))
                   (cons win (cons lose tail))))))

  (define (convert freq)
    (cond ((null? freq) '())
          (else (cons (htree-leaf (caar freq) (cdar freq)) (convert (cdr freq))))))

  (define (process freq1)
    (cond ((= (length freq1) 1) (car freq1))
          (else (let* ((mint0 (findMin freq1))
                       (t0 (car mint0))
                       (freq2 (cdr mint0))
                       (min2t0 (findMin freq2))
                       (t1 (car min2t0))
                       (freq3 (cdr min2t0)))
                  (process (cons (htree-node t0 t1) freq3))))))

"4."
(define (codeWords t)
  (define (traverse t signs)
    (cond ((eq? 'leaf (car t)) (list (cons (caddr t) (list->string (reverse signs)))))
          (else (append (traverse (caddr t) (cons #\0 signs)) (traverse (cadddr t) (cons #\1 signs))))))
  (traverse t '()))
