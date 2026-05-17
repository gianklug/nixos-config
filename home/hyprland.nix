{ config, pkgs, lib, inputs, ... }:

{
  # HYPA HYPA LAND
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;


    settings = {
      "$mod" = "SUPER";
      general = {
        allow_tearing = true;
        "col.active_border"="rgb(5bcefa) rgb(f5a9b8) rgb(ffffff) rgb(5bcefa) rgb(f5a9b8) 45deg";
        resize_on_border = true;
        snap = {
          enabled = true;
        };
      };
      decoration = {
          rounding = 18;

          blur = {
              enabled = true;
              xray = true;
              special = false;
              new_optimizations = true;
              size = 14;
              passes = 3;
              brightness = 1;
              noise = 0.04;
              contrast = 1;
              popups = true;
              popups_ignorealpha = 0.6;
              input_methods = true;
              input_methods_ignorealpha = 0.8;
          };

          shadow = {
              enabled = true;
              ignore_window = true;
              range = 30;
              offset = "0 2";
              render_power = 4;
              color = "rgba(00000010)";
          };
      };
      monitor = ["eDP-1, 2160x1350, 0x0, 1"];
      bind = [
        "$mod, return, exec, kitty"
        "$mod shift, Q, killactive"
        "$mod shift, space, togglefloating"
        "$mod, f, fullscreen"
        "$mod, D, exec, wofi --show drun"
        "$mod, L, exec, hyprlock"
        "$mod, V, exec, kitty --class clipse -e 'clipse'"
        # Window controls
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod shift, left, movewindow, l"
        "$mod shift, right, movewindow, r"
        "$mod shift, up, movewindow, u"
        "$mod shift, down, movewindow, d"
        # Custom keybinds
        ", Print, exec, grimblast save area - | satty -f -"
      ]
      # Workspaces
      ++ (builtins.genList (n: "$mod, ${toString (n + 1)}, workspace, ${toString (n + 1)}") 9)
      ++ (builtins.genList (n: "$mod shift, ${toString (n + 1)}, movetoworkspace, ${toString (n + 1)}") 9);
      bindm = [
        # mouse movements
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];
      gesture = [
        "4, horizontal, workspace"
        "3, up, scale: 1.5, fullscreen"
        "3, down, scale: 1.5, fullscreen"
      ];
      exec = [
        "pkill waybar; waybar"
        "pkill swaync; swaync"
      ];
      exec-once = [
        "nm-applet"
        "clipse -listen-shell"
      ];
      windowrulev2 = [
        "float,class:(clipse)"
        "size 622 652,class:(clipse)"
      ];
      windowrule = [
        "immediate,title:^(Celeste)$"
      ];
      input = {"kb_layout" = "ch";};
      dwindle = {"smart_split" = true;};
    };
  };
  # Hyprlock
  programs.hyprlock = {
    enable = true;
    settings = {
      general = {
        disable_loading_bar = false;
        grace = 1;
        hide_cursor = true;
        no_fade_in = false;
      };

      background = [
        {
          path = "screenshot";
          blur_passes = 3;
          blur_size = 8;
        }
      ];

      input-field = [
        {
          size = "200, 50";
          position = "0, -80";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(91, 96, 120)";
          outer_color = "rgb(24, 25, 38)";
          outline_thickness = 5;
          shadow_passes = 2;
        }
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = "${inputs.wallpapers}/jpgs/nix-d-nord-aurora.jpg";
      wallpaper = [
        ",${inputs.wallpapers}/jpgs/nix-d-nord-aurora.jpg"
      ];
    };

  };
}
