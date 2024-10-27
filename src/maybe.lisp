;;;; maybe.lisp

(in-package #:maybe)

;;; structs

(defstruct just
  value
  error)

;;; functions

(defun bind-maybe (value)
  (make-just :value value :error NIL))

(defun apply-maybe (value function &REST parameters)
  (if (maybe-error-p value)
      value
      (handler-case
	  (progn
	    (let* ((current-value (just-value value))
		   new-value
		   (parameter-list (append (list current-value) parameters)))
	      (setf new-value (apply function parameter-list))
	      (bind-maybe new-value)))
	(error (c)
	  (set-error value c)))))

(defun maybe-error-p (value)
  (if
   (and
    (just-p value)
    (null (just-error value)))
   NIL
   T))

(defun set-error (value label)
  (setf (just-error value) label)
  value)
