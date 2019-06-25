PROJECTNAME="go-proj-starter"
GOPROXY=GOPROXY=https://goproxy.cn
GOCMD=go
GOBUILD=$(GOCMD) build
GOCLEAN=$(GOCMD) clean
GOTEST=$(GOCMD) test
GOGET=$(GOCMD) get
MODD=modd
GOLINT=golint
DELVE=dlv
BIN_DIR=./bin

.PHONY: help
help: Makefile
	@echo
	@echo " Choose a command run in "$(PROJECTNAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'

## build: build a specific module. Runs `make build mod=crawlall`
.PHONY: build
build:
	$(GOBUILD) -o $(BIN_DIR)/$(mod) -v ./cmd/$(mod)

## run: run a specific module. Runs `make run mod=crawlds args="zgrd"`
.PHONY: run
run:
	$(GOBUILD) -o $(BIN_DIR)/$(mod) -v ./cmd/$(mod)
	$(BIN_DIR)/$(mod) $(args)

## webdev: run webdev server which will restart the server when filechanges
## NOTE: need modd.conf support
.PHONY: webdev
webdev:
	$(MODD)

## prod: run product server
.PHONY: prod
prod:
	$(GOBUILD) -o $(BIN_DIR)/server -v ./cmd/server
	$(BIN_DIR)/server -port=5000

## debug: debug starts a headless debug server. Runs `make debug mod=crawlall`
.PHONY: debug
debug:
	$(DELVE) debug ./cmd/$(mod) --headless -l localhost:33333 -- $(args)

## lint: run golint in all packages
.PHONY: lint
lint:
	@$(GOLINT) ./...

## test: test all the files
.PHONY: test
test:
	$(GOTEST) -v ./...

## deps: install all the deps the project needs
.PHONY: deps
deps:
	cp .hooks/* .git/hooks/
	$(GOPROXY) $(GOBUILD) -v ./...

## deps_web: install special deps for web dev
.PHONY: deps_web
deps_web:
	$(GOGET) github.com/cortesi/modd/cmd/modd

## clean: will remove all the binaries craeted by `make build`
.PHONY: clean
clean:
	rm $(BIN_DIR)/*

## build-linux: will build a linux-runnable binary. Runs `make build-linux mod=crawlall`
.PHONY: build-linux
build-linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) -o \
							$(BIN_DIR)/$(mod)-linux -v ./cmd/$(mod)
