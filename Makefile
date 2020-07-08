.PHONY: ci ac autocorrect lint loc

ci: lint
ac: autocorrect

lint:
	rubocop

autocorrect:
	rubocop -a

test:
	./Contents/Resources/test/run_tests.sh 

loc:
	cloc --vcs=git --exclude-dir=bundle,.bundle --not-match-f='(handlebars.js|zepto.js|raster.css)'

bundle_update:
	cd ./Contents/Resources/ &&\
		bundle update repla --full-index &&\
		bundle update &&\
		bundle clean &&\
		bundle install --standalone
