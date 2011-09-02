REBAR =$(shell which rebar || echo ./rebar)
ERL  ?= erl
APP  := ocicm
.PHONY: deps

all: deps
	@$(REBAR) compile
	@$(REBAR) compile

deps:
	@$(REBAR) get-deps

clean:
	@$(REBAR) clean

distclean:
	@$(REBAR) delete-deps
