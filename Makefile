NIXADDR ?= unset
NIXPORT ?= 22
NIXUSER ?= antti
NIXBLOCKDEVICE ?= unset
# Currently either home or work
NIXHOST ?= unset

SSH_OPTIONS=-o PubkeyAuthentication=no -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no

bootstrap:
	ssh $(SSH_OPTIONS) -p$(NIXPORT) root@$(NIXADDR) " \
		parted /dev/$(NIXBLOCKDEVICE) -- mklabel gpt; \
		parted /dev/$(NIXBLOCKDEVICE) -- mkpart primary 512MiB -8GiB; \
		parted /dev/$(NIXBLOCKDEVICE) -- mkpart primary linux-swap -8GiB 100\%; \
		parted /dev/$(NIXBLOCKDEVICE) -- mkpart ESP fat32 1MiB 512MiB; \
		parted /dev/$(NIXBLOCKDEVICE) -- set 3 esp on; \
		mkfs.ext4 -L NIXOS /dev/$(NIXBLOCKDEVICE)1; \
		mkswap -L swap /dev/$(NIXBLOCKDEVICE)2; \
		mkfs.fat -F 32 -n NIXBOOT /dev/$(NIXBLOCKDEVICE)3; \
		mount /dev/disk/by-label/NIXOS /mnt; \
		mkdir -p /mnt/boot; \
		mount /dev/disk/by-label/NIXBOOT /mnt/boot; \
		swapon /dev/$(NIXBLOCKDEVICE)2; \
  "

install:
	ssh $(SSH_OPTIONS) -p$(NIXPORT) root@$(NIXADDR) " \
		nixos-generate-config --root /mnt; \
		nix-env -iA nixos.git; \
		git clone https://github.com/anttih/dotfiles /mnt/etc/nixos/dotfiles; \
		nixos-install --flake /mnt/etc/nixos/dotfiles#$(NIXHOST); \
		reboot; \
  "

