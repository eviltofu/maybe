;;;; maybe.lisp

(in-package #:maybe)

;;; structs

(defstruct maybe
  value
  error)

;;; functions

(defun bind-value (value)
  (make-maybe :value value :error NIL))

(defun bind-error (er) 
  (make-maybe :value nil :error er))

(defun apply-function (value function &REST parameters)
  (if (error-p value)
      value
      (handler-case
	  (progn
	    (let* ((current-value (maybe-value value))
		   new-value
		   (parameter-list (append (list current-value) parameters)))
	      (setf new-value (apply function parameter-list))
	      (bind-value new-value)))
	(error (c)
	  (set-error value c)))))

(defun error-p (value)
  (if
   (and
    (maybe-p value)
    (not (null (maybe-error value))))
   T
   NIL))

(defun set-error (value label)
  (setf (maybe-error value) label)
  value)
