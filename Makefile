# Makefile - (c) rohan drape, 1998-2006

PROJECT = rsc

all:
	setup-plt -l $(PROJECT)

clean:
	rm -R compiled scheme/*/compiled
#	setup-plt -c -l $(PROJECT)

plt:
	rm -f $(PROJECT).plt.bz2
	mzc --collection-plt $(PROJECT).plt $(PROJECT)
	bzip2 $(PROJECT).plt

opt:
	mzc --collection-extension $(PROJECT)
