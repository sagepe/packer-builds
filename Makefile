# Simple Makefile wrapper.

.PHONEY: clean jessie wheezy test upload all

all: clean wheezy jessie

clean:
	@echo "Removing all box files."
	rm -f boxes/*.box

clobber: clean
	@echo "Removing ISO images."
	rm -f iso/*.iso
	@echo "Removing packer_cache directory."
	rm -fr packer_cache

jessie:
	@echo "Building Jessie."
	packer build -var-file=vars/jessie.json builders/debian.json

wheezy:
	@echo "Building Wheezy."
	packer build -var-file=vars/wheezy.json builders/debian.json

test:
	@echo "Test not implemented."

upload:
	@echo "Upload not implemented."
