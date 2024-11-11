all: morby home push
install: push

morby:
	./morby.sh

home:
	./home.sh

push:
	./push.sh