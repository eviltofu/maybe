LISP ?= ${shell which sbcl}
FLAGS ?= --noinform --no-sysinit --no-userinit --load .qlot/setup.lisp --quit 

.PHONY: test tests

test tests: ./tests/*.lisp
	qlot install
	@$(LISP) $(FLAGS) --eval "(asdf:test-system :maybe/tests)"

clean:
	@rm -f jet
	@rm -f *.fasl

