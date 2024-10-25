(in-package #:maybe/test)

(define-test :test-suite)

(define-test "bind-maybe-tests"
  :parent test-suite
  (let ((m (maybe:bind-maybe 100))
	(n (maybe:make-just
	    :value 50
	    :error "No"))) 

    (is = 100 (maybe:just-value m))
    (true (null (maybe:just-error m)))
    (true (maybe:just-p m))

    (true (string-equal "No" (just-error n)))
    (true (maybe-error-p n))
    (false (maybe-error-p m))))

(define-test "apply-maybe-tests"
  :parent test-suite
  (let (m n)
    (setf m (maybe:bind-maybe 9))
    (setf n (maybe:apply-maybe m #'+ 1))
    (true (maybe:just-p n))
    (false (maybe:maybe-error-p n))
    (is = 10 (maybe:just-value n))
    (maybe:set-error m "Overflow")
    (setf n (maybe:apply-maybe m #'- 1))
    (true (maybe:just-p n))
    (true (maybe:maybe-error-p n))
    (true (string-equal (maybe:just-error n) "Overflow"))))
