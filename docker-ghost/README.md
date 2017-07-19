# Ghost

Example of Ghost platform. Contains the following components:

+ `ngnix` - front proxy
+ `ghost` - ghost application
+ `mysql` - database

## Usage

Just:

	docker-compose up

Open Ghost in browser:

	http://localhost:80

Enjoy!


## Potential issues

It may happens that `ghost` starts before `mysql` (especially on the first run).
Just restart it all and it should work.
