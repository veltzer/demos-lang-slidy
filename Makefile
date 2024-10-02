##############
# parameters #
##############
# do you want to show the commands executed ?
DO_MKDBG:=0
# do you want dependency on the makefile itself ?!?
DO_ALLDEP:=1
# do you want to do 'pdf' from 'txt'?
DO_FMT_SLIDY_PDF:=1

########
# code #
########
# UNOPATH=UNOPATH="$(shell ls -d /opt/libreoffice*)"
# UNOPYTHON=$(UNOPATH)/program/python
UNOPATH=
UNOPYTHON=/usr/bin/python
UNOTIMEOUT=30
UNOWARNINGS=PYTHONWARNINGS="ignore::DeprecationWarning"

ALL:=

# silent stuff
ifeq ($(DO_MKDBG),1)
Q:=
# we are not silent in this branch
else # DO_MKDBG
Q:=@
#.SILENT:
endif # DO_MKDBG

# slidy
SLIDY_SRC:=$(shell find src -type f -and -name "*.txt")
SLIDY_BAS:=$(basename $(SLIDY_SRC))
SLIDY_PDF:=$(addprefix out/,$(addsuffix .pdf,$(SLIDY_BAS)))

ifeq ($(DO_FMT_SLIDY_PDF),1)
ALL+=$(SLIDY_PDF)
endif # DO_FMT_SLIDY_PDF

#########
# rules #
#########
.PHONY: all
all: $(ALL)
	@true

.PHONY: all_slidy
all_slidy: $(SLIDY_PDF)

.PHONY: debug
debug:
	$(info doing [$@])
	$(info UNOPATH is $(UNOPATH))
	$(info UNOPYTHON is $(UNOPYTHON))
	$(info ALL is $(ALL))
	$(info SLIDY_SRC is $(SLIDY_SRC))
	$(info SLIDY_PDF is $(SLIDY_PDF))

.PHONY: clean
clean:
	$(info doing [$@])
	$(Q)rm -f $(ALL)

.PHONY: clean_hard
clean_hard:
	$(info doing [$@])
	$(Q)git clean -qffxd

############
# patterns #
############
$(SLIDY_PDF): out/%.pdf: %.txt
	$(info doing [$@])
	$(Q)mkdir -p $(dir $@)
	$(Q)a2x -f pdf $<
	$(Q)mv $(basename $<).pdf $@

##########
# alldep #
##########
ifeq ($(DO_ALLDEP),1)
.EXTRA_PREREQS+=$(foreach mk, ${MAKEFILE_LIST},$(abspath ${mk}))
endif # DO_ALLDEP
