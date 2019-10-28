.PHONY: ci ac autocorrect lint

ci: lint
ac: autocorrect

lint:
	git ls-files *.rb *Rakefile *Gemfile -z | xargs -0 rubocop

autocorrect:
	git ls-files *.rb *Rakefile *Gemfile -z | xargs -0 rubocop -a

test:
	./Contents/Resources/test/run_tests.sh 

bundle_update:
	cd ./Contents/Resources/ &&\
		bundle update repla --full-index &&\
		bundle update &&\
		bundle clean &&\
		bundle install --standalone
