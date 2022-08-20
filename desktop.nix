{ pkgs, ... }: {
  services = {
    xserver = {
      enable = true;
      autorun = false;
      # windowManager.i3.enable = true;

      desktopManager.plasma5.enable = true;
      # displayManager.defaultSession = "plasma5";

      displayManager.lightdm.enable = true;
      displayManager.autoLogin.enable = true;
      displayManager.autoLogin.user = "antti";
    };

    postgresql = {
      enable = true;
      package = pkgs.postgresql_11;
    };
  };
}
