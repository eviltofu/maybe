;;;; package.lisp

(defpackage #:maybe
  (:use #:cl)
  (:export make-just
	   just
	   just-p
	   just-value
	   just-error
	   bind-value
	   bind-error
	   apply-function
	   error-p
	   set-error))
