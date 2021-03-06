#!/bin/sh
VM_DIRECTORY="$HOME/VMs"
echo resize_disk mysql-service: Detaching current disk... &&
vboxmanage storageattach mysql-service --storagectl 'SCSI' --port 0 --type hdd --medium none &&
echo resize_disk mysql-service: Cloning current disk... &&
vboxmanage clonehd --format VDI "$VM_DIRECTORY/mysql-service/ubuntu-xenial-16.04-cloudimg.vmdk" "$VM_DIRECTORY/mysql-service/ubuntu-xenial-16.04-cloudimg.vdi" &&
echo resize_disk mysql-service: Upsizing new disk... &&
vboxmanage modifyhd "$VM_DIRECTORY/mysql-service/ubuntu-xenial-16.04-cloudimg.vdi" --resize 122880 &&
echo resize_disk mysql-service: Attaching new disk... &&
vboxmanage storageattach mysql-service --storagectl 'SCSI' --port 0 --type hdd --medium "$VM_DIRECTORY/mysql-service/ubuntu-xenial-16.04-cloudimg.vdi" &&
echo resize_disk mysql-service: Deleting old disk... &&
vboxmanage closemedium "$VM_DIRECTORY/mysql-service/ubuntu-xenial-16.04-cloudimg.vmdk" --delete
