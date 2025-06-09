(define (make-tree value left right)
(list value left right))
(define (value T) (car T))
(define (right T) (caddr T))
(define (left T) (cadr T))

"Problem 1"
(define (tree-size T)
  (if (null? T) 0
      (+ 1 (tree-size (left  T)) (tree-size (right T)))
      )
  )

"Problem 2"
(define (tree-depth T)
  (if (or (null? T) (and (null? (left T)) (null? (right T)))) 0
      (let ((d-left (tree-depth (left T)))
            (d-right (tree-depth (right T))))
        (if (> d-left d-right)
            (+ 1 d-left)
            (+ 1 d-right)))))

"Problem 3"
(define (count-pred P tree)
  (if (null? tree) 0
      (if (P (value tree)) (+ 1 (count-pred P (left tree)) (count-pred P (right tree)))
          (+ 0 (count-pred P (left tree)) (count-pred P (right tree)))
      )
      )
  )

"Problem 4"
(define (count-one-child tree)
  (let ((lc (left tree))
        (rc (right tree)))
    (cond ((and (null? lc)(null? rc)) 0)
          ((and (not (null? lc))
                (not (null? rc)))
           (+ (count-one-child lc)(count-one-child rc)))
          ((null? lc)(+ 1 (count-one-child rc)))
          (else (+ 1 (count-one-child lc))))))
                
"Problem 5"
(define (invert-bst T)
  (if (null? T) (list)
       (make-tree (value T)
               (invert-bst(right T))
               (invert-bst(left T)))
       )
  )