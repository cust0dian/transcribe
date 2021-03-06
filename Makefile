JSCS = node_modules/.bin/jscs
JSHINT = node_modules/.bin/jshint
NPM = npm
XYZ = node_modules/.bin/xyz --repo git@github.com:plaid/transcribe.git --script scripts/prepublish

JS_EXAMPLES = $(shell find examples -name '*.js' | sort)
MD_EXAMPLES = $(JS_EXAMPLES:.js=.md)


.PHONY: all
all: $(MD_EXAMPLES)

%.md: %.js bin/transcribe
	bin/transcribe --url 'https://github.com/plaid/transcribe/blob/v$(VERSION)/{filename}#L{line}' -- '$<' >'$@'


.PHONY: lint
lint:
	$(JSHINT) -- bin/transcribe $(JS_EXAMPLES)
	$(JSCS) -- bin/transcribe $(JS_EXAMPLES)


.PHONY: release-major release-minor release-patch
release-major release-minor release-patch:
	@$(XYZ) --increment $(@:release-%=%)


.PHONY: setup
setup:
	$(NPM) install


.PHONY: test
test:
