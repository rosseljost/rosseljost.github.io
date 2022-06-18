.PHONY: build run full run-interactive

build:
	docker build \
		--rm \
		-f "Dockerfile" \
		-t tufte-pandoc:latest \
		.

run:
	docker run \
		--rm -it \
		-v "$(shell pwd)/content:/content" \
		-v "$(shell pwd)/content-rendered:/content-rendered" \
		-v "$(shell pwd)/docs:/docs" \
		-v "$(shell pwd)/meta:/meta" \
		tufte-pandoc:latest

full: build run

run-interactive:
	docker run \
		--rm -it \
		-v "$(shell pwd)/content:/content" \
		-v "$(shell pwd)/content-rendered:/content-rendered" \
		-v "$(shell pwd)/docs:/docs" \
		-v "$(shell pwd)/meta:/meta" \
		--entrypoint bash \
		tufte-pandoc:latest
