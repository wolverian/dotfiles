{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/sda";

  networking = {
    hostName = "nixos"; # Define your hostname.
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 22 ];
    firewall.allowPing = true;
  };
}
