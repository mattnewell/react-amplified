BINARY_NAME=go-service

build:
	env GOOS=linux GOARCH=386 go build -o bin/$(BINARY_NAME) ./src/

docker-build:
	docker build --rm --tag $(BINARY_NAME) .