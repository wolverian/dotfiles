* Boot a new VM using the nixos live CD with root password set to "root"
* Check the ip number of the VM: `ifconfig`
* Update the Makefile with the ip and then run `make vm/bootstrap` in the _host_
* The previous step will reboot into the live CD again, remove the media, and reboot the VM.
* ssh to the VM `ssh root@<ip>`
* `mv /etc/nixos/dotfiles /home/antti/dotfiles && chown antti:users -R /home/antti/dotfiles`
* Change remote `origin` to `git@github.com:anttih/dotfiles.git`
* `rm /etc/nixos/configuration.nix`
* Set password for `antti` with `sudo passwd antti`
* scp the private and public key to the machine
* `ssh-add ~/.ssh/<key>`