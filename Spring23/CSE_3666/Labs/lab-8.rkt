(define (h-min H) (car H))
(define (left H) (cadr H))
(define (right H) (caddr H))
(define (create-heap v H1 H2)
  (list v H1 H2))

(define (heap-insert f x H)
  (if (null? H) (create-heap x '() '())
      (let ((child-value (max x (h-min H)))
            (root-value (min x (h-min H))))
        (if (f 0 1) (create-heap root-value (right H) (heap-insert f child-value (left H)))
        (create-heap child-value (left H) (heap-insert f root-value (right H))))
         )))

(define (combine f Ha Hb)
  (cond ((null? Ha) Hb)
    ((null? Hb) Ha)
    ((f (h-min Ha) (h-min Hb))
     (list (h-min Ha)
                  Hb
                  (combine f (left Ha) (right Ha))))
    (else (list (h-min Hb) Ha(combine f (left Hb) (right Hb))))))

(define (empty? H)
    (if (null? H) #t #f))
  
(define (heap-remove f H)
  (combine f (left H) (right H)))
