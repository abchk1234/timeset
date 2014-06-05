VERSION = 1.3
SHELL = /bin/bash
INSTALL = /usr/bin/install
MSGFMT = /usr/bin/msgfmt
SED = /bin/sed
DESTDIR =
bindir = /usr/bin
localedir = /usr/share/locale
icons = /usr/share/pixmaps
deskdir = /usr/share/applications
mandir = /usr/share/man/man1/
appdir = /usr/share/timeset-$(VERSION)

all:

install: all
	$(INSTALL) -d $(DESTDIR)$(bindir)
	$(INSTALL) -d $(DESTDIR)$(icons)
	$(INSTALL) -d $(DESTDIR)$(deskdir)
	$(INSTALL) -d $(DESTDIR)$(appdir)
	$(INSTALL) -m755 timeset.sh $(DESTDIR)$(bindir)/timeset
	$(INSTALL) -m644 timeset.png $(DESTDIR)$(icons)
	$(INSTALL) -m644 timeset.desktop $(DESTDIR)$(deskdir)
	$(INSTALL) -m644 AUTHORS $(DESTDIR)$(appdir)
	$(INSTALL) -m644 CHANGELOG $(DESTDIR)$(appdir)
	$(INSTALL) -m644 README $(DESTDIR)$(appdir)
	$(INSTALL) -m644 COPYING $(DESTDIR)$(appdir)
	$(INSTALL) -m644 makefile $(DESTDIR)$(appdir)
	for file in po/*.mo; \
	do \
		lang=$$(echo $$file | $(SED) -e 's#.*/\([^/]\+\).mo#\1#'); \
		$(INSTALL) -d $(DESTDIR)$(localedir)/$$lang/LC_MESSAGES; \
		$(INSTALL) -m644 $$file  $(DESTDIR)$(localedir)/$$lang/LC_MESSAGES/timeset.mo; \
	done
