# Helper for Terraform workspace
#	terraform workspace [delete, list, new, select, show]

current := $(shell terraform workspace show)
target ?= $(current)

init: 
	./init.sh

set:
	@terraform workspace select $(target)
	@echo Workspace: $(shell terraform workspace show)

plan: set
	@terraform plan -var-file=./config/$(target).tfvars -out=$(target).plan

show: 
	@terraform show $(target).plan

apply: set
	terraform apply $(target).plan

graph:
	terraform graph | dot -Tsvg > graph.svg
	
destroy: 
	terraform workspace select $(target)
	terraform destroy -var-file=./config/$(target).tfvars -auto-approve