(define (make-tree value left right) (list value left right))
(define (value tree) (car tree))
(define (left tree) (cadr tree))
(define (right tree) (caddr tree))
(define empty-tree? null?)

(define (insert-list insert-elements T)
    (if (null? insert-elements) T
        (insert-list (cdr insert-elements)
                     (insert (car insert-elements) T))))
                 
(define (insert-element T)
    (cond ((null? T) (make-tree element '() ’()))
          ((<element (value T)) (make-tree (value T)
                                           (insert-element (left T ))
                                           (right T )))
                                       (else (make-tree (value T) 1
                                                        (left T)
                                                        (insert element (right T))))))