{ pkgs, ... }: {
  services = {
    xserver = {
      enable = true;
      autorun = true;
      # windowManager.i3.enable = true;

      desktopManager.mate.enable = true;
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
