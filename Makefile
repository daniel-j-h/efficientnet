dockerimage ?= danieljh/efficientnet
dockerfile ?= Dockerfile.cpu
srcdir ?= $(shell pwd)
datadir ?= $(shell pwd)


install:
	@docker build -t $(dockerimage) -f $(dockerfile) .

i: install


run:
	@docker run -it --rm --ipc="host" -v $(srcdir)/efficientnet:/usr/src/app/efficientnet -v $(datadir):/data --entrypoint=/bin/bash $(dockerimage)

r: run


update:
	@docker build -t $(dockerimage) -f $(dockerfile) . --pull --no-cache

u: update


publish:
	@docker image save $(dockerimage) \
	  | pv -N "Publish $(dockerimage) to $(sshopts)" -s $(shell docker image inspect $(dockerimage) --format "{{.Size}}") \
	  | ssh $(sshopts) "docker image load"

p: publish


.PHONY: install i run r update u publish p
