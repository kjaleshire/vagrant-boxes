##### MySQL Notes

There is no password on the root user.

Again, a word of note, the port forwarding interface VirtualBox uses is quite slow, especially if you're doing several multi-gigabyte `mysqldump`'s or imports. I recommend you use the VM IP + port directly.

This directory contains a script to convert and enlarge the default box disk from a non-enlargable VMDK (VMWare Disk) image to a VDI (VirtualBox Disk Image). 40GB I feel is not enough space for more than a few decent-size databases.

To run this script:

1. `vagrant halt`; the box *must* be shut down.
2. Modify the `VM_DIRECTORY` variable inside to point to your VirtualBox VM directory. I believe the default is `~/VirtualBox VMs`; I personally have VirtualBox set to use `~/VMs`.
3. Run it: `bash resize_disk.sh`. This will take several minutes.
4. Done! Continue using the box like usual.
