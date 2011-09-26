%.html : %.lss
	pandoc \
		-c rsc3.css \
		-r markdown+lhs \
		-w html \
		< $< \
		> $*.html

all:
	make tutorial.html

clean:
	rm -f *.html
