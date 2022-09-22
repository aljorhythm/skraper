setup:
	git config core.hooksPath .githooks
	npm ci
	npx playwright@1.26.0 install --with-deps chromium webkit

format-check:
	npx prettier --check .

format:
	npx prettier --write .

.PHONY: build
build:
	npm run build

.PHONY: test
test:
	npm run test

test-nowatch:
	npm run test:nowatch

test-with-external:
	npm run test:external

test-with-external-nowatch:
	npm run test:external:nowatch

test-e2e:
	sh test-e2e.sh

.PHONY: dev
dev:
	npm run dev

run:
	npm run start