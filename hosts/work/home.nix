{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    mate.mate-terminal
  ];
}
