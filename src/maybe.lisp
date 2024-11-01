;;;; maybe.lisp

(in-package #:maybe)

;;; structs

(defstruct just
  value
  error)

;;; functions

(defun bind-value (value)
  (make-just :value value :error NIL))

(defun bind-error (er) 
  (make-just :value nil :error er))

(defun apply-function (value function &REST parameters)
  (if (error-p value)
      value
      (handler-case
	  (progn
	    (let* ((current-value (just-value value))
		   new-value
		   (parameter-list (append (list current-value) parameters)))
	      (setf new-value (apply function parameter-list))
	      (bind-value new-value)))
	(error (c)
	  (set-error value c)))))

(defun error-p (value)
  (if
   (and
    (just-p value)
    (not (null (just-error value))))
   T
   NIL))

(defun set-error (value label)
  (setf (just-error value) label)
  value)
