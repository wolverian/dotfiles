{ pkgs, ... }: {
  services = {
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
}
