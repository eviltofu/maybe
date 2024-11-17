;;;; maybe.lisp

(in-package #:maybe)

;;; structs

(defstruct maybe
  value
  (error nil :type (or null condition)))

;;; functions

(declaim (ftype (function (t) maybe) bind-value))
(defun bind-value (value)
  (make-maybe :value value :error NIL))

(declaim (ftype (function (condition) maybe) bind-error))
(defun bind-error (er) 
  (make-maybe :value nil :error er))

(declaim (ftype (function (maybe function &rest t) maybe) apply-function))
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

(declaim (ftype (function (maybe) boolean) error-p))
(defun error-p (value)
  (if
   (and
    (maybe-p value)
    (not (null (maybe-error value))))
   T
   NIL))

(declaim (ftype (function (maybe condition) maybe) set-error))
(defun set-error (value label)
  (setf (maybe-error value) label)
  value)
