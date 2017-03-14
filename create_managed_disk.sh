#!/bin/bash

#variables
diskname="JD-Stor-Demo"
rgname="JDTest"
vmname="CentOsJD"
loc="centralus"
disk_id=$(az disk show -n $diskname -g $rgname | jq -r '.id')

#Managed Disk Creation for binaries
az disk create \
    -n $diskname \
    -g $rgname \
    --size-gb 20

#attach created disk to VM
az vm disk attach \
    --vm-name $vmname \
    -g $rgname \
    --disk $disk_id
