;;;; package.lisp

(defpackage #:maybe
  (:use #:cl)
  (:export make-just
	   just
	   just-p
	   just-value
	   just-error
	   bind-maybe
	   apply-maybe
	   maybe-error-p
	   set-error))
