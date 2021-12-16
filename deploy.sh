#!/usr/bin/env bash
# set -x
# set -e

function error() {
	echo "'${1-parameter}' failed with exit code $? in function '${FUNCNAME[1]}' at line ${BASH_LINENO[0]}" &&
		exit 1
}

function deploy() {

	deploy_env=${deploy_env:="dev"}
	ansible_tags=${ansible_tags:="sampleContainerDeployProcess"}
	ansible_skip_tags=${ansible_skip_tags:="never"}
	target_hosts_group=${target_hosts_group:="local"}

	case "${deploy_env}" in
	"dev")
		inventory_file="kubernetes-playbooks/inventories/development/hosts.yml"
		;;
	"staging")
		inventory_file="kubernetes-playbooks/inventories/staging/hosts.yml"
		;;
	"prod")
		inventory_file="kubernetes-playbooks/inventories/production/hosts.yml"
		;;
	*)
		echo "Unknown environment [${build_env}] have to be either dev, staging or prod"
		exit 1
		;;
	esac

	echo "INVENTORY TO DEPLOY ${inventory_file} environment is ${build_env}"

	if [ -z ${inventory_file} ]; then
		echo "Inventory file is not defined. Exit!!!"
		exit 1
	elif [ -z ${target_hosts_group} ]; then
		echo "Target hosts group is not defined. Exit!!!"
		exit 1
	else
		ansible-playbook \
			-i ${inventory_file} \
			--tags ${ansible_tags} \
			--skip-tags ${ansible_skip_tags} \
			-e env_variable=${build_env} \
			-e target_hosts=${target_hosts_group} \
			kubernetes-playbooks/deploy.yml -v || error "deploy"
	fi

}

deploy
