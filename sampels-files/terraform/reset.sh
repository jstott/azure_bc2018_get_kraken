read -r -p "Are you sure? [y/N] " response
if [[ "$response" =~ ^([yY][eE][sS]|[yY])+$ ]]; then
	rm -Rd .terraform
	rm -Rd terraform.tfstate.d
fi
