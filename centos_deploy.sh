#!/bin/bash

#Variables

rgname="JDTest"
vmname="CentOsJD"
loc="centralus"
urn="OpenLogic:CentOS:6.5:6.5.20170207" #run 'az vm image list -f [name-goes-here] --all --output table' to find URN
username="jldeen" #needs to be at least 6 characters
cidr="10.100.10.0/24"
ip="10.100.10.10"
sshkey="~/.ssh/ACSDemo.pub"

# Create Resource Group

az group create -l $loc -n $rgname
echo "Created Resource Group:" $rgname

#Centos 6.5 Create

az vm create \
    -n $vmname \
    -g $rgname \
    --image $urn \
    --admin-username $username \
    --subnet-address-prefix $cidr \
    --private-ip-address $ip \
    --ssh-key-value $sshkey \

echo "Created CentOS 6.5 Virtual Machine $vmname in $rgname"

#Custom Script Extension to install pkg dependencies
az vm extension set \
    --name CustomScript \
    --publisher Microsoft.Azure.Extensions \
    --version 2.0 \
    --vm-name $vmname \
    --resource-group $rgname \
    --settings public.json