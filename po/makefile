APPNAME=timeset

MSGLANGS=$(notdir $(wildcard *.po))

MSGOBJS=$(addprefix locale/,$(MSGLANGS:.po=/LC_MESSAGES/$(APPNAME).mo))

locale/%/LC_MESSAGES/$(APPNAME).mo: %.po
	msgfmt -c -o $*.mo $*.po

gettext: $(MSGOBJS)

