# DESTDIR is defined in dh_auto_install
# Ref: https://www.debian.org/doc/manuals/maint-guide/modify.ja.html
BINDIR=$(DESTDIR)/usr/bin
BIN_DEST=bin/issagen
INSTALL?=/usr/bin/install
RM?=/bin/rm -f

all:
	@echo "Run 'make install' to install"

install:
	${INSTALL} -d ${BINDIR}
	${INSTALL} -m755 ${BIN_DEST} ${BINDIR}

uninstall:
	${RM} ${BINDIR}/${BIN_DEST}

deinstall: uninstall
