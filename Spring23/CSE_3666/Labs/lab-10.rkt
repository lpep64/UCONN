"1."
(define (fact n)
  (define (helper n prod)
    (if (= n 0) prod
        (helper (- n 1) (* n prod))))
  (helper n 1))

"2."
(define (new-account initial-balance)
  (let ((balance initial-balance))
    (define (deposit f)
      (set! balance (+ balance f)) balance)
     (define (withdraw f)
      (cond ((> f balance)  "Insufficient funds")
            (else
               (set! balance (- balance f))
               balance)))
    (define (bal-inq) balance)
    (define interest .01)
    (define (accrue)
      (set! balance (+ balance (* balance interest))) balance)
    (define (setrate f)
      (set! interest f))
    (lambda (method)
      (cond ((eq? method 'deposit) deposit)
            ((eq? method 'withdraw) withdraw)
            ((eq? method 'balance-inquire) bal-inq)
            ((eq? method 'accrue) accrue)
            ((eq? method 'setrate) setrate)
            (else 'undefined-operation)))))


  