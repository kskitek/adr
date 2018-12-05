SHELL := /bin/bash

.PHONY: new

all: help

FNAME=`echo $(title) | sed -e 's/ /_/'`
STATUS=draft
LABELS=

.ONESHELL:
new:
	cp .template.md $(FNAME)
	# @sed -i -e 's/@TITLE/$(title)/g' $(FNAME)

help:
	help="Architectural Decisions Record\n

	@echo "Help meeee!"