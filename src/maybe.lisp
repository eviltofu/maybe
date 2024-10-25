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
      (let ((new-value
	      (apply function
		     (append (list (just-value value)) parameters))))
	(bind-maybe new-value))))

(defun maybe-error-p (value)
  (if
   (and
    (just-p value)
    (null (just-error value)))
   NIL
   T))

(defun set-error (value label)
  (setf (just-error value) label))
