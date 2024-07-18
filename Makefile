## This is an example Makefile for getting started with makestuff
## I'll try to simulate some kind of SIR model's behavior

current: target
-include target.mk
Ignore = target.mk

# -include makestuff/perl.def

vim_session:
	bash -cl "vmt README.md"

######################################################################

# Don't know if this will create the .md files... I'm about to find out
# First attempt was a fail, now I added to the bash line

######################################################################

Sources += Makefile README.md

Sources += $(wildcard *.md)

#####################################################################

autopipeR = Orli

## R Machinery
Sources += $(wildcard *.R)

## Orli!!!!

## base.R pars.R plotMod.R SIRModFun.R
## This is a rule that make already knows; it's here for the user
## base.Rout: base.R

## To make a parameters file we use the shell script pars.R to cascade one or more other files; this is a default rule in case there's just one

## base.pars.Rout: base.R
%.pars.Rout: pars.R %.R
	$(pipeR)

### make a plot for a given set of parameters
%.plotMod.Rout: plotMod.R SIRModFun.R %.pars.rda
	$(pipeR)

###############################

### Makestuff

Sources += Makefile


## Dushoff seems to think .gitignore should not be pushed. I'm not clear on the 
## theory of this yet. 

Ignore += makestuff
Ignore += .gitignore 

msrepo = https://github.com/dushoff

Makefile: makestuff/00.stamp
makestuff/%.stamp:
	- $(RM) makestuff/*.stamp
	(cd makestuff && $(MAKE) pull) || git clone $(msrepo)/makestuff
	touch $@

-include makestuff/os.mk

-include makestuff/pipeR.mk

-include makestuff/git.mk
-include makestuff/visual.mk
