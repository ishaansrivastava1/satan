AUTOBUILD	:= build
#LANGUAGES       := fr

include Makefile.common

#build: clean translations all
build: clean all
	set -e; for FORMAT in $(FORMATS); do \
		mkdir -p $(AUTOBUILD)/$$FORMAT; \
		cp *.$$FORMAT $(AUTOBUILD)/$$FORMAT; \
	done

	sed '{s/@DATE@/$(shell LC_ALL=C date -R)/;s%/@LANG@%%;}' build-index.html.in > $(AUTOBUILD)/index.html.en

	set -e; for LANGUAGE in $(LANGUAGES); do \
		for FORMAT in $(FORMATS); do \
			mkdir -p $(AUTOBUILD)/$$FORMAT/$$LANGUAGE; \
			cp $$LANGUAGE/*.$$FORMAT $(AUTOBUILD)/$$FORMAT/$$LANGUAGE; \
		done; \
		sed "{s/@DATE@/$(shell LC_ALL=C date -R)/;s/@LANG@/$$LANGUAGE/;}" $$LANGUAGE/build-index.html.in > $(AUTOBUILD)/index.html.$$LANGUAGE; \
	done

	cp css/* $(AUTOBUILD)
	cp img/* $(AUTOBUILD)
	cp scripts/* $(AUTOBUILD)

po4a:
	po4a -k 0 po4a/live-manual.cfg;

translations: po4a
	set -e; for LANGUAGE in $(LANGUAGES); do \
		mkdir -p $$LANGUAGE; \
		cp -r xml/entities/ $$LANGUAGE; \
		cp -r xsl/ $$LANGUAGE; \
		cp Makefile.common $$LANGUAGE/Makefile; \
		$(MAKE) -C $$LANGUAGE; \
	done

clean:
	-rm -rf $(LANGUAGES)
	rm -f *.html *.pdf *.txt
	rm -f xml/entities/version.ent

purge: clean
	rm -rf build

.PHONY: clean po4a translations
