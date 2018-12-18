.PHONY: new

all: help

ifndef $(EDITOR)
	@EDITOR=vim
endif

ifndef $(labels)
	@labels=
endif


IDX=.idx
CURR_IDX=$$(cat $(IDX))
FNAME=$$(echo $(CURR_IDX)_$(title).md | sed -e 's/ /_/g')

# .ONESHELL:
## new: create new ADR. Example: make new title="ADR title" labels="serviceA,go,java"
new:
	@$(eval f=$(FNAME))
	@cp .template.md $(FNAME)
	@sed -ie 's/@TITLE/$(title)/g' $(FNAME)
	@sed -ie 's/@LABELS/$(labels)/g' $(FNAME)
	@echo "Record created: $(FNAME)"
	@echo `expr $(CURR_IDX) + 1` > $(IDX) 


SEARCH_FILTER=$$(echo $(label) | sed -e 's/,/|/g')

## search: searches ARD by label. Example: make search label=serviceA
search:
	@ag -l "^labels=(.*,)*($(SEARCH_FILTER)).*" 


LINK_FROM=$$(find . -name "$(from)_*.md" | cut -c 3-)
LINK_TO=$$(find . -name "$(to)_*.md" | cut -c 3-)

## link: links one ADR in another. Example: make link from=10 to=1
link:
	@echo "* [$(LINK_FROM)]" >> $(LINK_TO)

help: Makefile
	@echo " Architectural Decisions Records. Choose a command run:"
	@sed -n 's/^##//p' $< | column -t -s ':' |  sed -e 's/^/ /'