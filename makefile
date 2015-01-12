NAME = timeset
VERSION = 1.6
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
docdir = /usr/share/doc/$(NAME)
appdir = /usr/share/$(NAME)-$(VERSION)

all:
	cd po; make gettext

install: all
	$(INSTALL) -d $(DESTDIR)$(bindir)
	$(INSTALL) -d $(DESTDIR)$(icons)
	$(INSTALL) -d $(DESTDIR)$(deskdir)
	$(INSTALL) -d $(DESTDIR)$(docdir)
	$(INSTALL) -d $(DESTDIR)$(appdir)
	$(INSTALL) -m755 bin/timeset.sh $(DESTDIR)$(bindir)/timeset
	$(INSTALL) -m644 install/timeset.png $(DESTDIR)$(icons)
	$(INSTALL) -m644 install/timeset.desktop $(DESTDIR)$(deskdir)
	$(INSTALL) -m644 AUTHORS $(DESTDIR)$(docdir)
	$(INSTALL) -m644 CHANGELOG $(DESTDIR)$(docdir)
	$(INSTALL) -m644 README.md $(DESTDIR)$(docdir)
	$(INSTALL) -m644 COPYING $(DESTDIR)$(docdir)
	$(INSTALL) -m644 makefile $(DESTDIR)$(appdir)
	for file in po/*.mo; \
	do \
		lang=$$(echo $$file | $(SED) -e 's#.*/\([^/]\+\).mo#\1#'); \
		$(INSTALL) -d $(DESTDIR)$(localedir)/$$lang/LC_MESSAGES; \
		$(INSTALL) -m644 $$file  $(DESTDIR)$(localedir)/$$lang/LC_MESSAGES/timeset.mo; \
	done

uninstall:
	rm $(DESTDIR)$(bindir)/$(NAME)
	rm $(DESTDIR)$(icons)/$(NAME).png
	rm $(DESTDIR)$(deskdir)/$(NAME).desktop
	rm -r $(DESTDIR)$(docdir)
	rm -r $(DESTDIR)$(appdir)
	rm $(DESTDIR)/usr/share/locale/*/LC_MESSAGES/$(NAME).mo
