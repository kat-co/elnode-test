all: build

build: src
	charm build -o $(shell pwd)/dist/ src/

deploy: dist
	juju deploy --repository="dist/" local:trusty/test-app

upgrade: dist
	juju upgrade-charm --repository="dist/" test-app
