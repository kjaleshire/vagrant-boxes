#!/bin/sh
VM_DIRECTORY="$HOME/VMs"
vboxmanage storageattach mysql-service --storagectl 'SATAController' --port 0 --device 0 --type hdd --medium none
vboxmanage clonehd --format VDI $VM_DIRECTORY/mysql-service/box-disk1.vmdk $VM_DIRECTORY/mysql-service/box-disk1.vdi
vboxmanage modifyhd $VM_DIRECTORY/mysql-service/box-disk1.vdi --resize 122880
vboxmanage storageattach mysql-service --storagectl 'SATAController' --port 0 --device 0 --type hdd --medium $VM_DIRECTORY/mysql-service/box-disk1.vdi
vboxmanage closemedium $VM_DIRECTORY/mysql-service/box-disk1.vmdk --delete
