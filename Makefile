# Makefile - (c) rohan drape, 1998-2007

PROJECT = rsc

all:
	setup-plt -l $(PROJECT)

clean:
	rm -fR compiled */compiled */*/compiled
#	setup-plt -c -l $(PROJECT)

plt:
	rm -f $(PROJECT).plt.bz2
	mzc --collection-plt $(PROJECT).plt $(PROJECT)
	bzip2 $(PROJECT).plt

opt:
	mzc --collection-extension $(PROJECT)
