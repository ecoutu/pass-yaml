PREFIX ?= /usr
DESTDIR ?=
LIBDIR ?= $(PREFIX)/lib
SYSTEM_EXTENSION_DIR ?= $(LIBDIR)/password-store/extensions
MANDIR ?= $(PREFIX)/share/man
BASHCOMPDIR ?= /etc/bash_completion.d

all:
	@echo "pass-yaml is a shell script and does not need compilation, it can be simply executed."
	@echo ""
	@echo "To install it try \"make install\" instead."
	@echo
	@echo "To run pass yaml one needs to have some tools installed on the system:"
	@echo "     password store"
	@echo "     yq"

install:
	@install -v -d "$(DESTDIR)$(MANDIR)/man1"
	@install -v -m 0644 man/pass-yaml.1 "$(DESTDIR)$(MANDIR)/man1/pass-yaml.1"
	@install -v -d "$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/"
	@install -v -m0755 src/yaml.bash "$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/yaml.bash"
	@install -v -d "$(DESTDIR)$(BASHCOMPDIR)/"
	@install -v -m 644 completion/pass-yaml.bash.completion  "$(DESTDIR)$(BASHCOMPDIR)/pass-yaml"
	@echo
	@echo "pass-yaml is installed succesfully"
	@echo

uninstall:
	@rm -vrf \
		"$(DESTDIR)$(SYSTEM_EXTENSION_DIR)/yaml.bash" \
		"$(DESTDIR)$(MANDIR)/man1/pass-yaml.1" \
		"$(DESTDIR)$(BASHCOMPDIR)/pass-yaml"

lint:
	shellcheck -s bash src/yaml.bash

.PHONY: install uninstall lint