#!/bin/bash
ip=`jq -r '.outputs.ip_address.value[] | select(."mw-aws-proxy-1a-slo-squid") | ."mw-aws-proxy-1a-slo-squid"' terraform.tfstate`
echo "ssh ubuntu@$ip ..."
ssh -i ./workload_ssh_key -o "StrictHostKeyChecking=no" ubuntu@$ip
