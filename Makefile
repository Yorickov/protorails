install:
	bundle install

run:
	rackup

push:
	git push -u origin master

lint:
	bundle exec rubocop

get:
	curl localhost:9292/articles$(P) -v

post:
	curl localhost:9292/articles -v -X POST -d ''
