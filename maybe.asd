;;;; maybe.asd

(asdf:defsystem #:maybe
  :description "A Maybe Monad Implementation in Common Lisp"
  :author "Jerome Chan <eviltofu@mac.com>"
  :license  "GPLv3"
  :version "0.0.1"
  :serial t
  :components ((:module "src"
                :components ((:file "package")
                             (:file "maybe"))))
  
  :in-order-to ((asdf:test-op (asdf:test-op "maybe/tests"))))

(asdf:defsystem #:maybe/tests
  :depends-on ("maybe" "parachute")
  :perform (asdf:test-op (op c) (uiop:symbol-call :maybe/test :test-framework))
  :components ((:module "tests"
                :components ((:file "package")
			     (:file "tests")))))

