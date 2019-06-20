dockerimage ?= danieljh/efficientnet
dockerfile ?= Dockerfile.cpu
srcdir ?= $(shell pwd)
datadir ?= $(shell pwd)

i:
	  @docker build -t $(dockerimage) -f $(dockerfile) .

r:
	  @docker run -it --rm --ipc="host" -v $(srcdir)/efficientnet:/usr/src/app/efficientnet -v $(datadir):/data --entrypoint=/bin/bash $(dockerimage)

u:
	  @docker build -t $(dockerimage) -f $(dockerfile) . --pull --no-cache


.PHONY: i r u
