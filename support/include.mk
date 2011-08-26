## -*- makefile -*-

######################################################################
## Erlang and XSLT

ERL := erl
ERLC := $(ERL)c
XSLTPROC := xsltproc

INCLUDE_DIRS := ../include $(wildcard ../deps/*/include)
EBIN_DIRS := $(wildcard ../deps/*/ebin)
ERLC_FLAGS := -W $(INCLUDE_DIRS:../%=-I ../%) $(EBIN_DIRS:%=-pa %)

ifndef no_debug_info
  ERLC_FLAGS += +debug_info
endif
  ERLC_FLAGS += -Ddebug

ifdef debug
  ERLC_FLAGS += -Ddebug
endif

EBIN_DIR := ../ebin
TEST_DIR := ../tests
DOC_DIR  := ../doc
IDL_DIR := ../specs/idl
EMULATOR := beam
IDL := idl

ERL_SOURCES := $(wildcard *.erl)
ERL_HEADERS := $(wildcard *.hrl) $(wildcard ../include/*.hrl)
ERL_OBJECTS := $(ERL_SOURCES:%.erl=$(EBIN_DIR)/%.$(EMULATOR))
#ERL_DOCUMENTS := $(ERL_SOURCES:%.erl=$(DOC_DIR)/%.html)
ERL_OBJECTS_LOCAL := $(ERL_SOURCES:%.erl=./%.$(EMULATOR))
APP_FILES := $(wildcard *.app)
#EBIN_FILES = $(ERL_OBJECTS) $(ERL_DOCUMENTS) $(APP_FILES:%.app=../ebin/%.app)
#EBIN_FILES = $(ERL_OBJECTS) $(APP_FILES:%.app=../ebin/%.app)
EBIN_FILES = $(ERL_OBJECTS) 
EBIN_FILES_NO_DOCS = $(ERL_OBJECTS) $(APP_FILES:%.app=../ebin/%.app)
MODULES = $(ERL_SOURCES:%.erl=%)

XSLT_TRANSFORMATION := $(IDL_DIR)/idl-extract.xslt
XML_SOURCES := $(Wildcard *.xml)
IDL_OBJECTS := $(XML_SOURCES:%.xml=$(IDL_DIR)/%.$(IDL))
IDL_FILES = $(IDL_OBJECTS)

TEST_ERL_SOURCES := $(wildcard test/*.erl)
TEST_ERL_OBJECTS = $(TEST_ERL_SOURCES:%.erl=$(TEST_DIR)/%.$(EMULATOR))
TEST_FILES = $(TEST_ERL_OBJECTS)

FULL_PATH_TO_EBIN := `cd ../ebin && pwd` # For common test stuff
../ebin/%.app: %.app
	cp $< $@

$(TEST_DIR)/%.$(EMULATOR): %.erl
	$(ERLC) $(ERLC_FLAGS) -o $(TEST_DIR) $<

$(EBIN_DIR)/%.$(EMULATOR): %.erl
	$(ERLC) $(ERLC_FLAGS) -o $(EBIN_DIR) $<

./%.$(EMULATOR): %.erl
	$(ERLC) $(ERLC_FLAGS) -o . $<


$(IDL_DIR)/%.$(IDL): %.xml
	$(XSLTPROC) $(XSLT_TRANSFORMATION) -o $(IDL_DIR) $<

./%.$(IDL): %.xml
	$(XSLTPROC) -o . $<

#$(DOC_DIR)/%.html: %.erl
#	$(ERL) -noshell -run edoc file $< -run init stop
#	mv *.html $(DOC_DIR)
