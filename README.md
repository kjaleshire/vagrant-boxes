### A collection of opinionated single-purpose Vagrant boxes.

#### Setup

1. Make sure you have (VirtualBox)[https://www.virtualbox.org] installed.
2. `cd` into one of the directories
3. Run `vagrant up`

Easy-peasy, wot?

#### Configuration

Each app exposes its configuration as an ERB template inside the `conf` directory. This template is rendered and copied over the guest's configuration when the machine is provisioned.

The configuration is re-rendered each time the `vagrant` command is run but *not* copied again. You must copy it over again within the guest. Check out the bootstrap script for details.

#### Notes

Each box will bind its default app port onto the host machine's localhost interface, i.e. `localhost:3306` for MySQL. However you should prefer using the VM's interface directly since the forwarding interface is quite slow, by almost 10x.

Once a box disk has expanded its size, it will never automatically shrink again. Hence I have included `zerofree` to be installed during provisioning. If your box disk is taking up more space in the host than you feel is necessary, you may compact the image like so:

1. `vagrant halt` to shut down the box.
2. Open VirtualBox, you'll need the actual console window open.
3. Start the VM; *very quickly* as soon as its window opens, click on it and hold left shift.
4. If your timing was good you will see the Ubuntu boot list; otherwise try again (make sure the window has captured the mouse, see VirtualBox docs for details).
5. Select `Advanced options for Ubuntu`, then `Ubuntu, with Linux 3.xx.x-xx-GENERIC (recovery mode)`. The OS will boot.
6. When the recovery menu appears, select `root // Drop to root shell prompt`.
7. When prompted enter the password `vagrant`. You should now have a root shell.
8. Run `umount /dev/sda1` to unmount the main filesystem.
9. Run `zerofree /dev/sda1` to zero out all free space. This may take several minutes depending.
10. Once `zerofree` has finished its thing, shut down the VM, either from VirtualBox or `shutdown -h now`.
11. `cd` to the directory for the VM in particular (*not* the Vagrantfile directory), usually within `~/VirtualBox VMs`.
12. Run `vboxmanage modifyhd --compact <disk_name>` where `disk_name` is the name of the virtual hard disk, e.g. `box-disk1.vmdk`. This will also take several minutes.
13. Done! Continue using the box as usual.
