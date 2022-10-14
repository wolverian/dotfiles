{ pkgs, user, ... }:

{
  nix = {
    package = pkgs.nixVersions.stable;
    extraOptions = ''
      experimental-features = nix-command flakes
      keep-outputs = true
      keep-derivations = true
    '';
  };

  nixpkgs.config.allowUnfree = true;

  time.timeZone = "Europe/Helsinki";

  environment = {
    variables = {
      EDITOR = "nvim";
      VISUAL = "nvim";
    };
  };

  users.users.root.initialPassword = "root";
  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
    shell = pkgs.zsh;
  };
  security.sudo.wheelNeedsPassword = false;

  services = {
    openssh.enable = true;
    openssh.passwordAuthentication = true;
    openssh.permitRootLogin = "yes";
    qemuGuest.enable = true;
    spice-vdagentd.enable = true;
    mpd.enable = true;
  };

  virtualisation.docker.enable = true;

  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
  networking.firewall.allowPing = true;

  programs.ssh.startAgent = true;

  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = ["JetBrainsMono"]; })
  ];

  system.stateVersion = "22.05"; # Did you read the comment?
}


