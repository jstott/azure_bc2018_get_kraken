#!/bin/bash
set -eo pipefail
read -r -p "Are you sure? [y/N] - this will destroy everything? " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
	make destroy target=dev 
	make destroy target=qa 
	# this will remove any workspace and state files as well
	rm -Rd .terraform 
	rm -Rd terraform.tfstate.d 
fi