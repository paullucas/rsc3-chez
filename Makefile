all:
	(cd mk; make install)

clean:
	(cd mk; make clean)

push-sp:
	darcs push -a rd@slavepianos.org:sw/rsc3

pull-sp:
	darcs pull -a http://rd.slavepianos.org/sw/rsc3
