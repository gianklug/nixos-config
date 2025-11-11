{ config, pkgs, lib, ... }:

{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 20;
        modules-left = [ "hyprland/workspaces"];
        modules-center = ["hyprland/window"];
        modules-right = [
          "idle_inhibitor"
          "pulseaudio"
          "network"
          "cpu"
          "memory"
          "temperature"
          "backlight"
          "battery"
          "clock"
          "custom/power"
          "tray"
       ];


        network = {
            format-wifi = "{essid} ({signalStrength}%) ";
            format-ethernet = "{ipaddr}/{cidr} ";
            tooltip-format = "{ifname} via {gwaddr} ";
            format-linked = "{ifname} (No IP) ";
            format-disconnected = "Disconnected ⚠";
            format-alt = "{ifname}= {ipaddr}/{cidr}";
          };

        pulseaudio = {
            format = "{volume}% {icon} {format_source}";
            format-bluetooth = "{volume}% {icon} {format_source}";
            format-bluetooth-muted = " {icon} {format_source}";
            format-muted = " {format_source}";
            format-source = "{volume}% ";
            format-source-muted = "";
            format-icons = {
                headphone = "";
                hands-free = "";
                headset = "";
                phone = "";
                portable = "";
                car = "";
                default = ["" "" ""];
            };
            on-click = "pavucontrol";
          };


        idle_inhibitor = {
            format = "{icon}";
            format-icons = {
                activated = "";
                deactivated = "";
            };
        };
        tray = {
            spacing = 10;
        };
        clock = {
            interval = 1;
            format= "{:%Y-%m-%d - %H:%M:%S}";
        };
        cpu = {
            format = "{usage}% ";
            tooltip = false;
        };
        memory = {
            format = "{}% ";
        };
        temperature = {
            critical-threshold = 80;
            format = "{temperatureC}°C {icon}";
            format-icons = ["" "" ""];
        };
        backlight = {
            format = "{percent}% {icon}";
            format-icons = ["" "" "" "" "" "" "" "" ""];
        };
        battery = {
            states = {
                good = 95;
                warning = 30;
                critical = 15;
            };
            format = "{capacity}% {icon}";
            format-full = "{capacity}% {icon}";
            format-charging = "{capacity}% ";
            format-plugged = "{capacity}% ";
            format-alt = "{time} {icon}";
            format-icons = ["" "" "" "" ""];
        };
      };

    };
    style = ''
    @define-color base   #1e1e2e;
    @define-color mantle #181825;
    @define-color crust  #11111b;
    
    @define-color text     #cdd6f4;
    @define-color subtext0 #a6adc8;
    @define-color subtext1 #bac2de;
    
    @define-color surface0 #313244;
    @define-color surface1 #45475a;
    @define-color surface2 #585b70;
    
    @define-color overlay0 #6c7086;
    @define-color overlay1 #7f849c;
    @define-color overlay2 #9399b2;
    
    @define-color blue      #89b4fa;
    @define-color lavender  #b4befe;
    @define-color sapphire  #74c7ec;
    @define-color sky       #89dceb;
    @define-color teal      #94e2d5;
    @define-color green     #a6e3a1;
    @define-color yellow    #f9e2af;
    @define-color peach     #fab387;
    @define-color maroon    #eba0ac;
    @define-color red       #f38ba8;
    @define-color mauve     #cba6f7;
    @define-color pink      #f5c2e7;
    @define-color flamingo  #f2cdcd;
    @define-color rosewater #f5e0dc;
    
    * {
      font-family: FantasqueSansMono Nerd Font;
      font-size: 15px;
      min-height: 0;
    }

    #window {
      margin-bottom: 0px;  
    }

    window#waybar {
      border-bottom: 0px;
      background: transparent;
    }    

    #waybar {
      background: transparent;
      color: @text;
      margin: 5px 5px;
    }
    
    #workspaces {
      margin: 0px;
      border-radius: 1rem;
      background-color: @surface0;
      margin-left: 1rem;
    }
    
    #workspaces button {
      color: @lavender;
      border-radius: 1rem;
      padding: 0px;
      padding-left: 0.4rem;
      padding-right: 0.4rem;
    }
    
    #workspaces button.active {
      color: @sky;
      border-radius: 1rem;
    }
    
    #workspaces button:hover {
      color: @sapphire;
      border-radius: 1rem;
    }
    
    #custom-music,
    #tray,
    #backlight,
    #clock,
    #battery,
    #pulseaudio,
    #idle_inhibitor,
    #pulseaudio,
    #network,
    #cpu,
    #memory,
    #temperature {
      background-color: @surface0;
      padding: 0.5rem 1rem;
      border-radius: 1rem 0px 0px 1rem;
      margin: 5px 0;
    }
    
    #clock {
      color: @blue;
      border-radius: 0px 1rem 1rem 0px;
      margin-right: 1rem;
    }
    
    #battery {
      color: @green;
    }
    
    #battery.charging {
      color: @green;
    }
    
    #battery.warning:not(.charging) {
      color: @red;
    }
    
    #backlight {
      color: @yellow;
    }
    
    #backlight, #battery {
        border-radius: 0;
    }
    
    #pulseaudio {
      color: @maroon;
      margin-left: 1rem;
      margin-right: 1rem;
      border-radius: 1rem;
    }
    
    #network {
      color: @mauve;
      border-radius: 1rem;
    }
    
    #cpu{
      border-radius: 1rem 0px 0px 1rem;
      color: @lavender;
      margin-left: 1rem;
    }
    
    #memory {
        margin-right: 1rem;
        border-radius: 0px 1rem 1rem 0px;
        color: @red;
    }
    
    #tray {
      margin-right: 1rem;
      border-radius: 1rem;
    }

    #idle_inhibitor {
      padding-left: 10px;
      padding-right: 20px;
      margin-left: 1rem;
      border-radius: 1rem;
    }
    '';
  };
}
