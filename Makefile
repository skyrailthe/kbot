APP=$(shell basename $(shell git remote get-url origin))
REGISTRY=skyrail
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
TARGETOS=linux
TARGETARCH=arm64

format:
	gofmt -s -w ./

lint:
	golint

test:
	go test -v

get:
	go get

build: format
	CGO_ENABLED=0 GOOS=$(TARGETOS) GOARCH=$(TARGETARCH) go build -v -o kbot -ldflags "-X="github.com/skyrailthe/kbot/cmd.appVersion=${VERSION}

image:
	docker build . -t $(REGISTRY)/$(APP):$(VERSION)-$(TARGETARCH)

push:
	docker push $(REGISTRY)/$(APP):$(VERSION)-$(TARGETARCH)

clean:
	rm -rf kbot
>>>>>>> 16a1d325fc9f3c1c097735a34626f32ddd86fd51