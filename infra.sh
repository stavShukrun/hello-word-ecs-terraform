#!/bin/bash

if [[ -z $1 ]]; then
  echo """
       ERROR!
       No command was provided.
       """
  print_help
  exit 1
fi

print_help() {
  echo """
       usage: $0 <command> <option>
       Basic Commands:
       list                    List environments.
       apply                   Create or update default environment.
       destroy                 Destroy default environment.
       workspace <environment> Create or update environments.
       """
}

case $1 in
    workspace)
    if [ -z "$2" ]; then
        echo "Environment name not specified."
        print_help
        exit 1
      fi
      cd terraform
      terraform workspace select -or-create=true $2
      terraform apply -var name=$2
    ;;
    list)
      cd terraform
      terraform workspace list
      exit 0
    ;;
    apply)
      cd terraform
      terraform init
      terraform validate
      terraform apply
      exit 0
    ;;
    destroy)
      cd terraform
      terraform destroy
      terraform workspace select default
      terraform workspace delete $2
      exit 0
    ;;
    help|--help)
    print_help
    exit 0;;
    *)
    echo """
        ERROR!
        Illegal command \"$1\"
        """
    print_help
    exit 1;;
esac
#EOF