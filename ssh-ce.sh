#!/bin/bash
ip=`jq -r '.outputs.ip_address.value[] | select(."mw-aws-proxy-1a-m0") | ."mw-aws-proxy-1a-m0"' terraform.tfstate`
echo "ssh vesop@$ip ..."
ssh -i ~/.ves-internal/staging/id_rsa -o "StrictHostKeyChecking=no" vesop@$ip
