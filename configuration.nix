{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  nixpkgs.config.allowUnfree = true;

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/sda";

  networking.hostName = "nixos"; # Define your hostname.

  time.timeZone = "Europe/Helsinki";

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  users.users.root.initialPassword = "root";
  users.users.antti = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    shell = pkgs.zsh;
  };
  security.sudo.wheelNeedsPassword = false;

  services = {
    openssh.enable = true;
    openssh.passwordAuthentication = true;
    openssh.permitRootLogin = "yes";

    xserver = {
      enable = false;
      # autorun = false;
      # windowManager.i3.enable = true;
      # displayManager.defaultSession = "none+i3";
      # displayManager.lightdm.enable = true;
      # displayManager.autoLogin.enable = false;
      # displayManager.autoLogin.user = "antti";
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];

  programs.ssh.startAgent = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?
}

