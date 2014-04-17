PREFIX ?= /usr
DESTDIR ?=
BINDIR ?= $(PREFIX)/bin
MANDIR ?= $(PREFIX)/share/man
DOCDIR ?= $(PREFIX)/share/doc
APPDIR ?= $(PREFIX)/share/izulu
LANGDIR_DE ?= $(PREFIX)/share/locale/de/LC_MESSAGES
LANGDIR_EN ?= $(PREFIX)/share/locale/en/LC_MESSAGES

MANPAGES = doc/izulu.1.gz
LANGFILES = lang/de.mo lang/en.mo

.PHONY: install uninstall clean

doc/%.1.gz: doc/%.1
	gzip -c $< > doc/$*.1.gz

lang/%.mo: lang/%.po
	msgfmt $< -o lang/$*.mo

all: $(MANPAGES) $(LANGFILES)

install: 
	@install -d "$(DESTDIR)$(BINDIR)" "$(DESTDIR)$(APPDIR)" "$(DESTDIR)$(MANDIR)/man1" "$(DESTDIR)$(DOCDIR)/izulu" "$(DESTDIR)$(LANGDIR_EN)" "$(DESTDIR)$(LANGDIR_DE)"
	@install -m 0755 -v izulu "$(DESTDIR)$(BINDIR)/izulu"
	@install -m 0644 -v gfx/forecast* "$(DESTDIR)$(APPDIR)/"
	@install -m 0644 -v gfx/gen_* "$(DESTDIR)$(APPDIR)/"
	@install -m 0644 -v doc/izulu.1.gz "$(DESTDIR)$(MANDIR)/man1/izulu.1.gz"
	@install -m 0644 -v doc/credits.txt "$(DESTDIR)$(DOCDIR)/"
	@install -m 0644 -v lang/en.mo "$(DESTDIR)$(LANGDIR_EN)/izulu.mo"
	@install -m 0644 -v lang/de.mo "$(DESTDIR)$(LANGDIR_DE)/izulu.mo"

clean:
	@rm -vf $(MANPAGES) $(LANGFILES)

uninstall:
	@rm -vf "$(DESTDIR)$(BINDIR)/izulu" "$(DESTDIR)$(MANDIR)/man1/izulu.1.gz" "$(DESTDIR)$(DOCDIR)/credits.txt" "$(DESTDIR)$(APPDIR)/*" "$(DESTDIR)$(LANGDIR_EN)/izulu.mo" "$(DESTDIR)$(LANGDIR_DE)/izulu.mo"
