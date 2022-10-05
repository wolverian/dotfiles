# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
    firewall.enable = true;
    firewall.allowedTCPPorts = [ 22 ];
    firewall.allowPing = true;
  };

  services.blueman.enable = true;

  hardware.opengl.enable = true;

  hardware.logitech.wireless.enable = true;
  hardware.logitech.wireless.enableGraphical = true;


  programs.sway = {
    enable = true;
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.bluetooth.enable = true;
}

