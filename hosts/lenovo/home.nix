{ pkgs, ... }:

{
  home.packages = with pkgs; [
    firefox
    alacritty
    rofi
    brightnessctl
    logitech-udev-rules
  ];

  home = {
    file.".config/wall".source = ./wall;
  };

  wayland.windowManager.sway = {
    enable = true;
    systemdIntegration = true;
    config = let borderColor ="#e27878"; in rec {
      modifier = "Mod4";
      terminal = "${pkgs.alacritty}/bin/alacritty";
      menu = "${pkgs.rofi}/bin/rofi -show drun";

      fonts = {
        names = [ "JetBrains Mono Nerd Font" ];
        size = 10.0;
      };

      gaps = {
        inner = 0;
        outer = 0;
        smartBorders = "on";
      };

      seat = {
        "*" = { hide_cursor = "when-typing enable"; };
      };

      window.border = 4; 

      input = {
        "type:pointer" = {
          natural_scroll = "enabled";
        };
        "type:touchpad" = {
          tap = "enabled";
          natural_scroll = "enabled";
        };
        "type:keyboard"= {
          xkb_options = "caps:ctrl_modifier";
          repeat_delay = "250";
          repeat_rate = "50";
        };
      };

      output = {
        "*".bg = "~/.config/wall fill";
      };
      bars = [];

      colors.focused.text = "#999999";
      colors.focused.background = "#8b98b6";

      colors.focused.indicator = borderColor;
      colors.focused.border = borderColor;
      colors.focused.childBorder = borderColor;

      keybindings = {
        "${modifier}+r" = "reload";
        "${modifier}+Escape" = "exec swaymsg exit";
        "${modifier}+Return" = "exec ${terminal}";
        "${modifier}+space" = "exec ${menu}";
        "${modifier}+Shift+a" = "exec swaylock -i ~/.config/wall";
        "${modifier}+f" = "fullscreen toggle";
        "${modifier}+l" = "focus right";
        "${modifier}+h" = "focus left";
        "${modifier}+k" = "focus up";
        "${modifier}+j" = "focus down";

        "${modifier}+Shift+h" = "move left";
        "${modifier}+Shift+l" = "move right";
        "${modifier}+Shift+k" = "move up";
        "${modifier}+Shift+j" = "move down";

        "${modifier}+Tab" = "workspace next_on_output";
        "${modifier}+Shift+Tab" = "workspace prev_on_output";

        "${modifier}+1" = "workspace number 1";
        "${modifier}+2" = "workspace number 2";
        "${modifier}+3" = "workspace number 3";
      };
    };

    extraConfig = ''
      set $laptop eDP-1
      bindswitch --locked --reload lid:on output $laptop disable
      bindswitch --locked --reload lid:off output $laptop enable
    '';
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    systemd.target = "sway-session.target";
    settings = [{
      layer = "top";
      position = "top";
      height = 30;
      output = ["DP-1" "eDP-1"];
      modules-left = ["sway/workspaces"];
      modules-center = ["sway/window"];
      modules-right = ["network" "cpu" "memory" "battery" "clock" "tray"];
      clock = {
        format = "{:%b %d %H:%M}";
      };
      cpu = {
        format = "cpu {}%";
      };
      battery = {
        format = "  {capacity}%";
      };
      memory = {
        format = "mem {percentage}%";
      };
      network = {
        format-wifi = " {essid} ({signalStrength}%)";
      };
    }];
    style = ''
      * {
          border: none;
          border-radius: 0;
          font-family: Helvetica, Arial, sans-serif;
          font-size: 15px;
          min-height: 0;
      }

      window#waybar {
          background: #1e2132;
          color: #c6c8d1;
          border-bottom: 2px solid #2a3158;
      }

      tooltip {
        background: rgba(43, 48, 59, 0.5);
        border: 1px solid rgba(100, 114, 125, 0.5);
      }

      tooltip label {
        color: white;
      }

      #workspaces button {
          padding: 0 10px;
          color: #c6c8d1;
          border-bottom: 3px solid transparent;
      }

      #workspaces button.focused {
          background-color: #2a3158;
      }

      #workspaces, #network, #clock, #battery, #cpu, #memory {
          padding: 0 10px;
      }

      #clock {
        color: #c6c8d1;
        background-color: #3d435c;
      }

      #cpu {
        color: #0f1117;
        background-color: #e27878;
      }

      #memory {
        color: #0f1117;
        background-color: #a093c7;
      }

      #battery {
        color: #0f1117;
        background-color: #b4be82;
      }

      #battery.charging {
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: black;
          }
      }

      #battery.warning:not(.charging) {
          background: #f53c3c;
          color: white;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }
    '';
  };

  programs.alacritty = {
    enable = true;
    settings = {
      font = {
        normal = {
          family = "JetBrains Mono Nerd Font";
        };
        bold = {
          family = "JetBrains Mono Nerd Font";
          style = "Medium";
        };
        size = 14.0;
      };
      colors = {
        primary = {
          background = "#161821";
          foreground = "#d2d4de";
        };

        normal= {
          black =  "#161821";
          red =    "#e27878";
          green=   "#b4be82";
          yellow=  "#e2a478";
          blue=    "#84a0c6";
          magenta= "#a093c7";
          cyan=    "#89b8c2";
          white=   "#c6c8d1";
        };

        bright = {
          black =    "#6b7089";
          red =      "#e98989";
          green =    "#c0ca8e";
          yellow =   "#e9b189";
          blue =     "#91acd1";
          magenta =  "#ada0d3";
          cyan =     "#95c4ce";
          white =    "#d2d4de";
        };

        cursor = {
          text= "#161821";
          cursor= "#d2d4de";
        };
      };
    };
  };
}

