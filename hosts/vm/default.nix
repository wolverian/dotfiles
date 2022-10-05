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

  services = {
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
  };

  networking = {
    hostName = "nixos"; # Define your hostname.
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 22 ];
    firewall.allowPing = true;
  };
}
