.PHONY: ci ac autocorrect lint

ci: lint
ac: autocorrect

lint:
	rubocop

test:
	./Contents/Resources/test/run_tests.sh 

autocorrect:
	rubocop -a

