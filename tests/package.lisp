;;;; Testing package

(defpackage #:maybe/test
  (:use #:cl #:parachute #:maybe))

(in-package #:maybe/test)

(defun test-framework ()
  (parachute:test 'maybe/test::test-suite))
