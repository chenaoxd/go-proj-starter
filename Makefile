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

help: Makefile
	@echo
	@echo " Choose a command run in "$(PROJECTNAME)":"
	@echo
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'

## deps: install all the deps the project needs
deps:
	cp .hooks/* .git/hooks/
	$(GOPROXY) $(GOBUILD) -v ./...

## build: build a specific module. Runs `make build mod=crawlall`
build:
	$(GOBUILD) -o $(BIN_DIR)/$(mod) -v ./cmd/$(mod)

## run: run a specific module. Runs `make run mod=crawlds args="zgrd"`
run:
	$(GOBUILD) -o $(BIN_DIR)/$(mod) -v ./cmd/$(mod)
	$(BIN_DIR)/$(mod) $(args)

## dev: run dev server
dev:
	$(GOBUILD) -o $(BIN_DIR)/server -v ./cmd/server
	$(BIN_DIR)/server

## webdev: run webdev server which will restart the server when filechanges
## NOTE: need modd.conf support
webdev:
	$(MODD)

## prod: run product server
prod:
	$(GOBUILD) -o $(BIN_DIR)/server -v ./cmd/server
	$(BIN_DIR)/server -port=5000

## debug: debug starts a headless debug server. Runs `make debug mod=crawlall`
debug:
	$(DELVE) debug ./cmd/$(mod) --headless -l localhost:33333 -- $(args)

## lint: run golint in all packages
lint:
	@$(GOLINT) ./...

## test: test all the files
test:
	$(GOTEST) -v ./...

## deps_web: install special deps for web dev
deps_web:
	$(GOGET) github.com/cortesi/modd/cmd/modd

## clean: will remove all the binaries craeted by `make build`
clean:
	rm $(BIN_DIR)/*

## build-linux: will build a linux-runnable binary. Runs `make build-linux mod=crawlall`
build-linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) -o \
							$(BIN_DIR)/$(mod)-linux -v ./cmd/$(mod)
