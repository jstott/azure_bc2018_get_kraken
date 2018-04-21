# ************************************************
# NOT INTENDED to be run as a script - but as placeholder 
# for lines to be executed as part of demo
# ************************************************

# simple ping
ansible web -i dev -m ping

# Info about a host
ansible lamp0 -i dev -m setup -a 'gather_subset=!all'
ansible -m setup localhost

# create user
ansible web -i dev -m user -a "name=test_user password=12345" --become
# apt-get update
ansible web -i dev -m apt -a "update_cache=true" --become
# add package Screenfetch
ansible web[0] -i dev -m apt -a "name=screenfetch state=present" --become

# SSH into VM
ssh -i ~/.ssh/ots_rsa automation@ots-lamp-dev-0.eastus2.cloudapp.azure.com

# sample hosts affected for playlist
ansible-playbook -i dev site.yml --list-hosts 
ansible-playbook -i qa site.yml --list-hosts
ansible-playbook -i dev site.yml --list-hosts --limit lamp1
ansible-playbook -i dev site.yml 

## Cowsay - have a little fun - assuming you have cowsay installed
## sudo apt-get install cowsay
cowsay -l
echo "holly cow - I'm a penguin" | cowsay -f tux
export ANSIBLE_COW_SELECTION=default
export ANSIBLE_NOCOWS=1