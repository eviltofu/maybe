(in-package #:maybe/test)

(define-condition test-error (error)
  ((message :initarg :message :reader message)))

(define-test :test-suite)

(define-test "bind-maybe-tests"
  :parent test-suite
  (let ((m (bind-value 100))
	(n (make-maybe
	    :value 50
	    :error (return-error "No")))) 

    (is = 100 (maybe-value m))
    (false (maybe-error m))
    (true (maybe-p m))
    (true (string-equal "No" (message (maybe-error n))))
    (true (error-p n))
    (false (error-p m))))

(define-test "bind-maybe-error-tests"
  :parent test-suite
  (true
   (error-p
    (bind-error
     (return-error "Unknown"))))
  (true
   (string-equal
    "Hello"
    (message
     (maybe-error
      (bind-error
       (return-error "Hello")))))))

(define-test "apply-maybe-tests"
  :parent test-suite
  (let (m n)
    (setf m (bind-value 9))
    (setf n (apply-function m #'+ 1))
    (true (maybe-p n))
    (false (error-p n))
    (is = 10 (maybe-value n))
    (set-error m (return-error "Errors"))
    (setf n (apply-function m #'- 1))
    (true (maybe-p n))
    (true (error-p n))
    (setf n (return-error "Errors"))
    (true (string-equal (message (maybe-error m)) (message n)))
    (setf m (bind-value 0))
    (setf n 0)
    (true (error-p (apply-function m #'/ 0)))))

(defun return-error (message)
  (make-condition 'test-error :message message))
