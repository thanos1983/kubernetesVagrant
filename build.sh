#!/usr/bin/env bash
# set -x
# set -e

function error() {
	echo "'${1-parameter}' failed with exit code $? in function '${FUNCNAME[1]}' at line ${BASH_LINENO[0]}" \
		&& exit 1
}

function build() {
		ansible_tags=${ansible_tags:="demo"}
		target_hosts_group=${target_hosts_group:="local"}

		ansible-playbook \
			--tags ${ansible_tags} \
			-e target_hosts=${target_hosts_group} \
			-i kubernetes-playbooks/inventory/sampleInventory/hosts.yml \
			kubernetes-playbooks/kubernetes.yml -v || error "build"
}

build
