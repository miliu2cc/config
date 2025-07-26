{ pkgs, ... }:
{
  # Configure & Theme Waybar
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        height = 32;
        spacing = 8;
        position = "bottom";
        layer = "top";
        margin-left = 16;
        margin-right = 16;
        margin-bottom = 8;

        modules-left = [
          "mpris"
        ];
        modules-center = [
          "idle_inhibitor"
          "pulseaudio"
          "cpu"
          "temperature"
          "backlight"
          "keyboard-state"
          "battery"
          "network"
          "tray"
        ];
        modules-right = [
          "river/tags"
          "clock"
        ];
        "river/tags" = {
          "num-tags" = 5;
        };
        "mpris" = {
          format = "{status}: {dynamic}";
          dynamic-len = 100;
        };
        "keyboard-state" = {
          "numlock" = true;
          "capslock" = true;
          "format" = " {name} {icon}";
          "format-icons" = {
            "locked" = "";
            "unlocked" = "";
          };
        };
        "idle_inhibitor" = {
          "format" = "{icon} ";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
        };
        "tray" = {
          "icon-size" = 20;
          "spacing" = 10;
        };
        "clock" = {
          # "timezone" = "Europe/Tallinn";
          "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
          "format-alt" = "{:%Y-%m-%d}";
        };
        "cpu" = {
          "format" = "{usage}% ";
          "tooltip" = false;
        };
        "memory" = {
          "format" = "{}% ";
        };
        "temperature" = {
          # "thermal-zone"= 2;
          "hwmon-path" = "/sys/class/hwmon/hwmon2/temp1_input";
          "critical-threshold" = 80;
          # "format-critical"= "{temperatureC}°C {icon}";
          "format" = "{temperatureC}°C {icon}";
          "format-icons" = [
            ""
            ""
            ""
          ];
        };
        "backlight" = {
          # "device": "acpi_video1",
          "format" = "{percent}% {icon}";
          "format-icons" = [
            ""
            ""
          ];
        };
        "battery" = {
          "states" = {
            # "good": 95,
            "warning" = 30;
            "critical" = 15;
          };
          "format" = "{capacity}% {icon} ";
          "format-charging" = "{capacity}%  ";
          "format-plugged" = "{capacity}%  ";
          "format-alt" = "{time} {icon}";
          # "format-good": "", // An empty format will hide the module
          # "format-full": "",
          "format-icons" = [
            ""
            ""
            ""
            ""
            ""
          ];
        };
        "network" = {
          # "interface": "wlp2*", // (Optional) To force the use of this interface
          "format-wifi" = "{signalStrength}%   ";
          "format-ethernet" = "Connected  ";
          "tooltip-format" = "{ifname} via {gwaddr} ";
          "format-linked" = "{ifname} (No IP) ";
          "format-disconnected" = "Disconnected ⚠ ";
          "format-alt" = "{ifname}: {ipaddr}/{cidr}";
        };
        "pulseaudio" = {
          "format" = "{volume}% {icon}";
          "format-bluetooth" = "{volume}% {icon}";
          "format-bluetooth-muted" = "{icon} {format_source}";
          "format-muted" = "{format_source}";
          "format-source" = "";
          "format-source-muted" = "";
          "format-icons" = {
            "headphone" = "";
            "hands-free" = "";
            "headset" = "";
            "phone" = "";
            "portable" = "";
            "car" = "";
            "default" = [
              ""
              ""
              ""
            ];
          };
          "on-click" = "pavucontrol";
        };
      };
    };
    style = ''
      * {
          border: none;
          border-radius: 0px;
          /* `otf-font-awesome` is required to be installed for icons */
          font-family: "Inter", Roboto, Helvetica, Arial, sans-serif;
          font-size: 15px;
          min-height: 0;
      }

      window#waybar {
          background-color: transparent;
          color: #ffffff;
          transition-property: background-color;
          transition-duration: .5s;
      }

      window#waybar.hidden {
          opacity: 0.2;
      }

      #workspaces button {
          background: #1f1f1f;
          color: #ffffff;
      }

      /* https://github.com/Alexays/Waybar/wiki/FAQ#the-workspace-buttons-have-a-strange-hover-effect */
      #workspaces button:hover {
          background: lightblue;
          color: black;
          border-bottom: 3px solid #ffffff;

      }

      #workspaces button.focused {
          background: #1f1f1f;
      }

      #workspaces button.focused:hover {
          background: lightblue;
          color: black;
          border-bottom: 3px solid #ffffff;

      }

      #workspaces button.urgent {
          background-color: #eb4d4b;
      }

      #mode {
          background-color: #64727D;
          border-bottom: 3px solid #ffffff;
      }

      #clock,
      #battery,
      #cpu,
      #memory,
      #disk,
      #temperature,
      #backlight,
      #network,
      #pulseaudio,
      #mpris,
      #custom-launcher,
      #custom-power,
      #custom-layout,
      #custom-updater,
      #custom-snip,
      #custom-wallpaper,
      #tags,
      #taskbar,
      #tray,
      #mode,
      #idle_inhibitor,
      #mpd {
          padding: 0 10px;
          color: #ffffff;
      }

      #window,
      #workspaces {
          margin: 0px 4px;
      }

      /* If workspaces is the leftmost module, omit left margin */
      .modules-left > widget:first-child > #workspaces {
          margin-left: 0px;
      }

      /* If workspaces is the rightmost module, omit right margin */
      .modules-right > widget:last-child > #workspaces {
          margin-right: 0px;
      }

      #clock {
          background-color: #171717;
          color: #ffffff;
          border: 1px solid #FFFFFF;
      }

      #battery {
          background-color: #ffffff;
          color: #000000;
          border: 1px solid #FFFFFF;
      }

      #battery.charging, #battery.plugged {
          color: #ffffff;
          background-color: #26A65B;
          border: 1px solid #FFFFFF;
      }

      @keyframes blink {
          to {
              background-color: #ffffff;
              color: #000000;
          }
      }

      #battery.critical:not(.charging) {
          background-color: #f53c3c;
          color: #ffffff;
          animation-name: blink;
          animation-duration: 0.5s;
          animation-timing-function: linear;
          animation-iteration-count: infinite;
          animation-direction: alternate;
      }

      label:focus {
          background-color: #000000;
      }

      #cpu {
          background-color: #171717;
          color: #ffffff;
          border: 1px solid #FFFFFF;
      }

      #memory {
          background-color: #171717;
          color: #ffffff;
          border: 1px solid #FFFFFF;
      }

      #disk {
          background-color: #171717;
          color: #ffffff;
          border: 1px solid #FFFFFF;

      }

      #backlight {
          background-color: #90b1b1;
          border: 1px solid #FFFFFF;

      }

      #network {
          background-color: #171717;
          color: #ffffff;
          border: 1px solid #FFFFFF;

      }

      #network.disconnected {
          background-color: #171717;
          color: red;
          border: 1px solid #FFFFFF;

      }

      #pulseaudio {
          background-color: #171717;
          color: #ffffff;
          border: 1px solid #FFFFFF;

      }

      #pulseaudio.muted {
          background-color: #171717;
          color: red;
          border: 1px solid #FFFFFF;

      }

      #mpris {
          background-color: #171717;
          color: white;
          border: 1px solid #FFFFFF;

      }

      #mpris.spotify {
          background-color: #171717;
          color: white;

          border: 1px solid #FFFFFF;

      }

      #mpris.vlc {
          background-color: #171717;
          color: white;
          border: 1px solid #FFFFFF;

      }

      #mpris.brave {
          background-color: #171717;
          color: white;
          border: 1px solid #FFFFFF;

      }

      #custom-power{
          background-color: #171717;
          font-size: 18px;
          margin-right: 5px;
          border: 1px solid #FFFFFF;

      }

      #custom-launcher{
          background-color: #171717;
          font-size: 20px;
          margin-left: 5px;
          border: 1px solid #FFFFFF;

      }

      #custom-layout{
          background-color: #171717;
          color: white;
          font-size:20px;
          border: 1px solid #FFFFFF;

      }

      #custom-updater {
          background-color: #171717;
          color: white;
          border: 1px solid #FFFFFF;

      }

      #custom-snip {
          background-color: #171717;
          color: skyblue;
          font-size: 20px;
          border: 1px solid #FFFFFF;

      }

      #custom-wallpaper {
          background-color: #171717;
          color: pink;
          font-size: 20px;
      }

      #tags{
          background-color: #171717;
          font-size: 20px;
          border: 1px solid #FFFFFF;
      }

      #tags button.occupied {
          color: pink;
          margin: 5px;
          background-color: #272727;
      }
      #tags button.focused {
          color: black;
          margin: 5px;
          background-color: white;
      }
      #tags button.urgent{
          color: red;
          margin: 5px;
          background-color:white;
      }


      #taskbar{
          background-color: #171717;
          border-radius: 0px 20px 20px 0px;
          border: 1px solid #FFFFFF;
      }

      #temperature {
          background-color: #171717;
          color: #ffffff;
          border: 1px solid #FFFFFF;
      }

      #temperature.critical {
          background-color: #eb4d4b;
      }

      #tray {
          background-color: #171717;
          color: #ffffff;
          border: 1px solid #FFFFFF;
      }

      #tray > .passive {
          -gtk-icon-effect: dim;
          background-color: #171717;
          color: #ffffff;
      }

      #tray > .needs-attention {
          -gtk-icon-effect: highlight;
          background-color: #171717;
          color: #ffffff;
      }

      #idle_inhibitor {
          background-color: #171717;
          border: 1px solid #FFFFFF;
      }

      #idle_inhibitor.activated {
          background-color: #171717;
          color: #ffffff;
          border-radius: 20px 0px 0px 20px;

      }

      #language {
          background-color: #171717;
          color: #ffffff;
          min-width: 16px;
          border: 1px solid #FFFFFF;
      }

      #keyboard-state {
          background: #97e1ad;
          color: #000000;
          min-width: 16px;
      }

      #keyboard-state > label {
          padding: 0px 5px;
      }

      #keyboard-state > label.locked {
          background: rgba(0, 0, 0, 0.2);
      }
    '';
  };
}
