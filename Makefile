# Simple Makefile wrapper.

.PHONEY: clean jessie wheezy test upload all

all: clean wheezy jessie stretch

clean:
	@echo "Removing all box files."
	rm -f boxes/*.box

clobber: clean
	@echo "Removing ISO images."
	rm -f iso/*.iso
	@echo "Removing packer_cache directory."
	rm -fr packer_cache

stretch:
	@echo "Building Stretch."
	packer build -var-file=vars/stretch.json builders/debian.json

jessie:
	@echo "Building Jessie."
	packer build -var-file=vars/jessie.json builders/debian.json

wheezy:
	@echo "Building Wheezy."
	packer build -var-file=vars/wheezy.json builders/debian.json

centos6:
	@echo "Building CentOS 6."
	packer build -var-file=vars/centos6.json builders/centos.json

test:
	@echo "Test not implemented."

upload:
	@echo "Upload not implemented."
