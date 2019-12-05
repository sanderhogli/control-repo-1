#!/bin/bash

# create a shared Hiera-directory for all environments
# to hold the data created with this script to avoid it
# being overwritten every time r10k is executed
# (this is just useful for our specific situation, 
# this is not generic best practice)
mkdir -p /etc/puppetlabs/code/shared-hieradata

# Create a passwordless keypair for root ssh
ssh-keygen -q -N '' -f /root/.ssh/id_rsa
echo "base_linux::root_ssh_key: $(cut -d ' ' -f 2 /root/.ssh/id_rsa.pub)" >> /etc/puppetlabs/code/shared-hieradata/common.yaml

# Password for Sensu backend
echo "sensu::backend::password: $(pwgen -s 16 1)" >> /etc/puppetlabs/code/shared-hieradata/common.yaml

# Password for AD
echo "profile::ad::server::password: $(pwgen 12 1)" >> /etc/puppetlabs/code/shared-hieradata/common.yaml

# THIS TYPICALLY SHOULD BE MOVED TO A SEPARATE SCRIPT AND EXECUTED
# ONCE IN THE GIT REPO AND COMMITTED (WHEN USED IN STUDENTS PROJECTS
# WHERE THIS REPO IS FORKED)
# create new passwords for all hiera keys ending with 'password'
#while read -r entry
#do
#  filename=$(echo "$entry" | cut -d ':' -f1)
#  key=$(echo "$entry" | cut -d ':' -f1 --complement)
#  blank_key=$(echo "$key" | grep -oE '^.*password:')
#  sed -i -E "s/($blank_key).*/\1 $(pwgen -s 16 1)/" "$filename"
#done < <(grep -rH 'password:' hieradata/*)
