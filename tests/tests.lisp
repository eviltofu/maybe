(in-package #:maybe/test)

(define-condition test-error (error)
  ((message :initarg :message :reader message)))

(define-test :test-suite)

(define-test "bind-maybe-tests"
  :parent test-suite
  (let ((m (bind-maybe 100))
	(n (make-just
	    :value 50
	    :error "No"))) 

    (is = 100 (just-value m))
    (false (just-error m))
    (true (just-p m))

    (true (string-equal "No" (just-error n)))
    (true (maybe-error-p n))
    (false (maybe-error-p m))))

(define-test "apply-maybe-tests"
  :parent test-suite
  (let (m n)
    (setf m (bind-maybe 9))
    (setf n (apply-maybe m #'+ 1))
    (true (just-p n))
    (false (maybe-error-p n))
    (is = 10 (just-value n))
    (set-error m (return-error "Errors"))
    (setf n (apply-maybe m #'- 1))
    (true (just-p n))
    (true (maybe-error-p n))
    (setf n (return-error "Errors"))
    (true (string-equal (message (just-error m)) (message n)))
    (setf m (bind-maybe 0))
    (setf n 0)
    (true (maybe-error-p (apply-maybe m #'/ 0)))))

(defun return-error (message)
  (make-condition 'test-error :message message))
