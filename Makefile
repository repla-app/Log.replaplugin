.PHONY: ci ac autocorrect lint loc gem_install

ci: gem_install lint
ac: autocorrect

lint:
	bundle exec rubocop

autocorrect:
	bundle exec rubocop -a

test:
	./Contents/Resources/test/run_tests.sh 

gem_install:
	bundle install --path vendor/bundle

loc:
	cloc --vcs=git --exclude-dir=bundle,.bundle --not-match-f='(handlebars.js|zepto.js|raster.css)'

bundle_update:
	cd ./Contents/Resources/ &&\
		bundle update repla --full-index &&\
		bundle update &&\
		bundle clean &&\
		bundle install --standalone
