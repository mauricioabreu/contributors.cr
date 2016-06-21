.PHONY: build test

build:
	crystal compile src/contributors/cli.cr -o contributors

test:
	crystal spec
