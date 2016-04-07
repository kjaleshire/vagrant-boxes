#!/bin/sh
VM_DIRECTORY="$HOME/VMs"
echo resize_disk postgresql-service: Detaching current disk...
vboxmanage storageattach postgresql-service --storagectl 'SATAController' --port 0 --device 0 --type hdd --medium none
echo resize_disk postgresql-service: Cloning current disk...
vboxmanage clonehd --format VDI "$VM_DIRECTORY/postgresql-service/box-disk1.vmdk" "$VM_DIRECTORY/postgresql-service/box-disk1.vdi"
echo resize_disk postgresql-service: Upsizing new disk...
vboxmanage modifyhd "$VM_DIRECTORY/postgresql-service/box-disk1.vdi" --resize 122880
echo resize_disk postgresql-service: Attaching new disk...
vboxmanage storageattach postgresql-service --storagectl 'SATAController' --port 0 --device 0 --type hdd --medium "$VM_DIRECTORY/postgresql-service/box-disk1.vdi"
echo resize_disk postgresql-service: Deleting old disk...
vboxmanage closemedium "$VM_DIRECTORY/postgresql-service/box-disk1.vmdk" --delete
