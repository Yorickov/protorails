install:
	bundle install

push:
	git push -u origin master

lint:
	bundle exec rubocop
