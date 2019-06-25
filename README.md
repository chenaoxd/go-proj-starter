# Golang Project Starter

This project contains the most common used features used in a golang project, which includes

- Makefile using to run most common functions
- Debug tool using [delve](https://github.com/go-delve/delve)
- Automatically install dependencies using [`GOPROXY`](https://github.com/golang/go/wiki/Modules#are-there-always-on-module-repositories-and-enterprise-proxies)
- Automatically restarted webdev server
- Cross compilation demonstration command
- Automatically linting before `git commit`

## Project Layout

### `/cmd`

Main applications for this project.

The directory name for each application should match the name of the executable you want to have (e.g., /cmd/myapp).

Don't put a lot of code in the application directory. If you think the code can be imported and used in other projects, then it should live in the /pkg directory. If the code is not reusable or if you don't want others to reuse it, put that code in the /internal directory. You'll be surprised what others will do, so be explicit about your intentions!

It's common to have a small main function that imports and invokes the code from the /internal and /pkg directories and nothing else.

( From <https://github.com/golang-standards/project-layout#cmd> )

### `/internal`

Private application and library code. This is the code you don't want others importing in their applications or libraries.Put your actual application code in the /in

ternal/app directory (e.g., /internal/app/myapp) and the code shared by those apps in the /internal/pkg directory (e.g., /internal/pkg/myprivlib).

( From <https://github.com/golang-standards/project-layout#internal> )

### References

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
