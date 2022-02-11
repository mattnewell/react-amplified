BINARY_NAME=go-echo

build:
	env GOOS=linux GOARCH=amd64 go build -o bin/$(BINARY_NAME) ./src/

docker-build:
	docker build --rm --tag $(BINARY_NAME) .