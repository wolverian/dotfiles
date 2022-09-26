{ pkgs, user, ... }: {
  services = {
    xserver = {
      enable = true;
      autorun = true;
      # windowManager.i3.enable = true;
      desktopManager.mate.enable = true;

      displayManager.lightdm.enable = true;
      displayManager.autoLogin.enable = true;
      displayManager.autoLogin.user = user;
    };

    postgresql = {
      enable = true;
      package = pkgs.postgresql_11;
    };
  };
}
