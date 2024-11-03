;;;; package.lisp

(defpackage #:maybe
  (:use #:cl)
  (:export make-maybe
	   maybe
	   maybe-p
	   maybe-value
	   maybe-error
	   bind-value
	   bind-error
	   apply-function
	   error-p
	   set-error))
