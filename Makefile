install:
	bundle install

run:
	rackup

push:
	git push -u origin master

lint:
	bundle exec rubocop
