# Golang Project Starter

This project contains the most common used features used in a golang project, which includes

- Makefile using to run most common functions
- Debug tool using [delve](https://github.com/go-delve/delve)
- Automatically install dependencies using [`GOPROXY`](https://github.com/golang/go/wiki/Modules#are-there-always-on-module-repositories-and-enterprise-proxies)
- Automatically restarted webdev server
- Cross compilation demonstration command
- Automatically linting before `git commit`

## Project Layout

Project layout is mainly referring the two following projects (articles):

1. [Standard Go Project Layout](https://github.com/golang-standards/project-layout)
2. [Standard Package Layout](https://medium.com/@benbjohnson/standard-package-layout-7cdbc8391fc1)

## Makefile

The [Makefile](./Makefile) contains all the most common used functions.

### `make help`

List all the available commands to run.

### `make deps`

Install all the dependencies using the [goproxy.io](https://goproxy.io) GOPROXY. And the golint pre-commit git hook will be installed too.

### `make run mod=module`

Run the specific module which is located in the cmd package.

### `make webdev`

Start an web dev server which will automatically restart when the `.go` files is modified. And this function is supported by [modd](https://github.com/cortesi/modd). You can change the server startup command by modifying the [modd.conf](./modd.conf) file.

### `make debug mod=module`

Start a delve debug server at localhost:33333, and then you can use some debug client to connect to the debug server such as [sebdah/vim-delve](https://github.com/sebdah/vim-delve) if you are using vim.

### `make lint`

Run go lint on all packages

### `make test`

Run all test code

### `make build-linux mod=module`

Cross compile the specific module, the default OS is set to linux and default ARCH is set to amd64.
