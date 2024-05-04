{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [ wl-clipboard ];

  # Window Manager Configuration + basic apps
  wayland.windowManager = {
    sway = rec {
      enable = true;
      catppuccin.enable = true;
      config = {
        modifier = "Mod4";
        terminal = "alacritty";
        keybindings =
          let
            modifier = config.modifier;
          in
          lib.mkOptionDefault {
            "${modifier}+Alt+Return" = "exec chromium";
            "${modifier}+0" = "workspace number 0";
            "${modifier}+Shift+0" = "move container to workspace number 0";
          };
        output = {
          "*" = {
            bg = "$base solid_color";
          };
          "DP-1" = {
            scale = "1.5";
          };
          "DP-2" = {
            transform = "270";
            position = "-1920 0";
          };
        };
        seat = {
          "*" = {
            hide_cursor = "1000";
          };
        };
        window = {
          titlebar = false;
        };
        colors = {
          background = "$base";
          focused = {
            childBorder = "$lavender";
            background = "$base";
            text = "$text";
            indicator = "$rosewater";
            border = "$lavender";
          };
          focusedInactive = {
            childBorder = "$overlay0";
            background = "$base";
            text = "$text";
            indicator = "$rosewater";
            border = "$overlay0";
          };
          unfocused = {
            childBorder = "$overlay0";
            background = "$base";
            text = "$text";
            indicator = "$rosewater";
            border = "$overlay0";
          };
          urgent = {
            childBorder = "$peach";
            background = "$base";
            text = "$peach";
            indicator = "$overlay0";
            border = "$peach";
          };
          placeholder = {
            childBorder = "$overlay0";
            background = "$base";
            text = "$text";
            indicator = "$overlay0";
            border = "$overlay0";
          };
        };
        bars = [ { command = "waybar"; } ];
        gaps = {
          inner = 10;
        };
      };
    };
    hyprland = {
      enable = false;
      catppuccin.enable = true;
      settings = {
        "$mod" = "SUPER";
        bind =
          [ "$mod, Enter, exec, alacritty" ]
          ++ (builtins.concatLists (
            builtins.genList (ws: [
              "$mod, ${toString ws}, workspace, ${toString ws}"
              "$mod SHIFT, ${toString ws}, movetoworkspace, ${toString ws}"
            ]) 10
          ));
      };
    };
  };

  programs.waybar = {
    enable = true;
    catppuccin.enable = true;
    style = ''
      * {
        font-family: monospace;
        font-size: 12px;
        min-height: 1rem;
      }

      #waybar {
        background: transparent;
        color: @text;
        margin: 1rem;
        padding: 1rem;
      }

      #tray,
      #clock
      {
        border-radius: 1rem 0 0 1rem;
        background-color: @surface1;
      }

      #clock {
        padding: 0 1rem;
        color: @blue;
      }

      #workspaces {
        margin: 0 1rem;
        padding: 0;
        border-radius: 1rem;
        background-color: @surface0;
      }

      #workspaces button {
        color: @lavender;
        border-radius: 1rem;
        padding: 0.4rem;
        background-color: @surface0;
      }

      #workspaces button.focused {
        color: @sky;
        background-color: @surface1;
      }
      #workspaces button:hover {
        color: @sapphire;
        border-radius: 1rem;
      }
    '';
    settings = {
      mainBar = {
        layer = "top";
        modules-center = [ "sway/window" ];
        modules-left = [
          "sway/workspaces"
          "sway/mode"
        ];
        modules-right = [
          "tray"
          "clock"
        ];
        position = "top";
        "wlr/workspaces" = {
          disable-scroll = true;
          format = " {name} ";
          format-icons = {
            default = " ";
          };
          sort-by-name = true;
        };
        tray = {
          icon-size = 21;
          spacing = 10;
        };
      };
    };
  };

  home.pointerCursor = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
  };

  # You'll need this
  programs.alacritty = {
    enable = true;
    catppuccin.enable = true;
  };

  # And this
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--ozone-platform-hint=wayland"
      "--force-dark-mode"
    ];
    extensions = [
      { id = "eimadpbcbfnmbkopoojfekhnkhdbieeh"; } # dark reader
      { id = "ghmbeldphafepmbegfdlkpapadhbakde"; } # proton pass
      { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # vimium
      { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # ublock origin
    ];
  };
}
