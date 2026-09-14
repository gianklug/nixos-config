{ config, pkgs, lib, inputs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    package = null;
    portalPackage = null;

    extraConfig = ''
      local function exec(command)
        return hl.dsp.exec_cmd(command)
      end

      local function bind(key, action, options)
        hl.bind(key, action, options or {})
      end

      local function direction_binds(modifier, action)
        local directions = { "left", "right", "up", "down" }

        for _, direction in ipairs(directions) do
          bind(modifier .. " + " .. direction, action(direction))
        end
      end

      hl.monitor({
        output = "eDP-1",
        mode = "preferred",
        position = "0x0",
        scale = 1,
      })

      hl.config({
        general = {
          allow_tearing = true,
          resize_on_border = true,

          col = {
            active_border = {
              colors = {
                "rgb(5bcefa)",
                "rgb(f5a9b8)",
                "rgb(ffffff)",
                "rgb(5bcefa)",
                "rgb(f5a9b8)",
              },
              angle = 45,
            },            
          },

          snap = {
            enabled = true,
          },
        },

        decoration = {
          rounding = 10,

          blur = {
            enabled = true,
            xray = true,
            special = false,
            new_optimizations = true,
            size = 14,
            passes = 3,
            brightness = 1,
            noise = 0.04,
            contrast = 1,
            popups = true,
            popups_ignorealpha = 0.6,
            input_methods = true,
            input_methods_ignorealpha = 0.8,
          },

          shadow = {
            enabled = true,
            range = 30,
            offset = "0 2",
            render_power = 4,
            color = "rgba(00000010)",
          },
        },

        input = {
          kb_layout = "ch",
        },

        dwindle = {
          smart_split = false,
          smart_resizing = false,
        },
      })

      bind("SUPER + Return", exec("kitty"))
      bind("SUPER + SHIFT + Q", hl.dsp.window.close())
      bind("SUPER + SHIFT + Space", hl.dsp.window.float({
        action = "toggle",
      }))
      bind("SUPER + F", hl.dsp.window.fullscreen({
        mode = "fullscreen",
      }))
      bind("SUPER + D", exec("wofi --show drun"))
      bind("SUPER + L", exec("hyprlock"))
      bind("SUPER + V", exec("kitty --class clipse -e clipse"))
      bind("PRINT", exec("grimblast save area - | satty -f -"))

      direction_binds("SUPER", function(direction)
        return hl.dsp.focus({
          direction = direction,
        })
      end)

      direction_binds("SUPER + SHIFT", function(direction)
        return hl.dsp.window.move({
          direction = direction,
        })
      end)

      for workspace = 1, 9 do
        local number = tostring(workspace)

        bind("SUPER + " .. number, hl.dsp.focus({
          workspace = number,
        }))

        bind("SUPER + SHIFT + " .. number, hl.dsp.window.move({
          workspace = number,
        }))
      end

      bind(
        "SUPER + mouse:272",
        hl.dsp.window.drag(),
        { drag = true }
      )

      bind(
        "SUPER + mouse:273",
        hl.dsp.window.resize(),
        { drag = true }
      )

      bind(
        "SUPER + ALT + mouse:272",
        hl.dsp.window.resize(),
        { drag = true }
      )

      hl.gesture({
        fingers = 4,
        direction = "horizontal",
        action = "workspace",
      })

      local function fullscreen_gesture(direction)
        hl.gesture({
          fingers = 3,
          direction = direction,
          scale = 1.5,
          action = function()
            hl.dispatch(hl.dsp.window.fullscreen({
              mode = "fullscreen",
            }))
          end,
        })
      end

      fullscreen_gesture("up")
      fullscreen_gesture("down")

      local function clipse_rule(name, properties)
        properties.name = name
        properties.match = {
          class = "clipse",
        }

        hl.window_rule(properties)
      end

      clipse_rule("clipse-float", {
        float = true,
      })

      clipse_rule("clipse-size", {
        size = "622 652",
      })

      hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
      hl.workspace_rule({ workspace = "f[1]", gaps_out = 0, gaps_in = 0 })
      hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0 })
      hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, rounding = 0 })
      hl.window_rule({ match = { float = false, workspace = "f[1]" }, border_size = 0 })
      hl.window_rule({ match = { float = false, workspace = "f[1]" }, rounding = 0 })

      hl.window_rule({
        name = "celeste-tearing",
        match = {
          title = "^Celeste$",
        },
        immediate = true,
      })

      hl.on("hyprland.start", function()
        local commands = {
          "waybar",
          "swaync",
          "nm-applet",
          "clipse -listen-shell",
        }

        for _, command in ipairs(commands) do
          hl.exec_cmd(command)
        end
      end)


      hl.curve("fast", {
          type = "bezier",
          points = {
              { 0.25, 1.0 },
              { 0.5, 1.0 }
          }
      })

      hl.animation({
          leaf = "windows",
          enabled = true,
          speed = 2,
          bezier = "fast",
          style = "popin 90%"
      })

      hl.animation({
          leaf = "workspaces",
          enabled = true,
          speed = 2,
          bezier = "fast",
          style = "slide"
      })

      hl.animation({
          leaf = "fade",
          enabled = true,
          speed = 1.5,
          bezier = "fast"
      })

      hl.animation({
          leaf = "layers",
          enabled = true,
          speed = 2,
          bezier = "fast"
      })      
    '';
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
      splash = false;
      wallpaper = [
        {
          path = "${inputs.wallpapers}/jpgs/nix-d-nord-aurora.jpg";
          fit_mode = "cover";
          monitor = "";
        }
      ];
    };

  };
}
