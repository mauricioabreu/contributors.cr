.PHONY: build test

build:
	crystal compile src/cli.cr -o contributors

test:
	crystal spec
