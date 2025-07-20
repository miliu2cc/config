# SPDX-FileCopyrightText: 2025 FreshlyBakedCake
#
# SPDX-License-Identifier: MIT

{ niri, walker }:
{
  project,
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [
    niri.result.homeModules.niri
    walker.result.homeManagerModules.walker
  ];

  options.niri = {
    wallpaper = lib.mkOption {
      type = lib.types.path;
      description = "Path to the desktop wallpaper you'd like to use";
    };
    lockscreen = lib.mkOption {
      type = lib.types.path;
      description = "Path to the lockscreen background you'd like to use, defaults to a greyscale version of your desktop wallpaper";
      default = pkgs.stdenv.mkDerivation {
        name = "niri-lock-background";

        src = config.niri.wallpaper;
        dontUnpack = true;

        buildPhase = ''
          ${pkgs.imagemagick}/bin/magick $src -colorspace Gray $out
        '';
      };
    };
    overviewBackground = lib.mkOption {
      type = lib.types.path;
      description = "Path to the overview background you'd like to use, defaults to a darkened, blurred version of your desktop wallpaper";
      default = pkgs.stdenv.mkDerivation {
        name = "niri-overview-background";

        src = config.niri.wallpaper;
        dontUnpack = true;

        buildPhase = ''
          ${pkgs.imagemagick}/bin/magick $src -blur 0x16 -fill black -colorize 40% $out
        '';
      };
    };
  };

  config = {
    programs.niri =
      let
        lock = ''${config.programs.niri.package}/bin/niri msg action do-screen-transition && ${pkgs.swaylock}/bin/swaylock -i ${config.niri.lockscreen} -s fill -f'';
      in
      {
        enable = true;

        package = pkgs.niri;

        settings = {
          environment = {
            NIXOS_OZONE_WL = "1";
            DISPLAY = ":0";
          };

          input.keyboard = {
            track-layout = "window";
            repeat-delay = 200;
            repeat-rate = 25;

            xkb = lib.mkIf (config.home.keyboard != null) {
              layout = if config.home.keyboard.layout == null then "" else config.home.keyboard.layout;
              model = if config.home.keyboard.model == null then "" else config.home.keyboard.model;
              options = builtins.concatStringsSep "," config.home.keyboard.options;
              variant = if config.home.keyboard.variant == null then "" else config.home.keyboard.variant;
            };
          };

          input.touchpad.natural-scroll = true;
          input.touchpad.click-method = "clickfinger";

          input.warp-mouse-to-focus.enable = true;
          input.focus-follows-mouse = {
            enable = true;
            max-scroll-amount = "0%";
          };

          input.power-key-handling.enable = false;

          binds =
            let
              inherit (config.lib.niri) actions;

              mod = "Super";

              generateWorkspaceBindings = workspaceNumber: {
                "${mod}+${builtins.toString (lib.mod workspaceNumber 10)}".action.focus-workspace = [
                  workspaceNumber
                ];
                "${mod}+Shift+${builtins.toString (lib.mod workspaceNumber 10)}".action.move-column-to-workspace = [
                  workspaceNumber
                ];
              };
              joinAttrsetList = listOfAttrsets: lib.fold (a: b: a // b) { } listOfAttrsets;
            in
            {
              "Mod+Q".action = close-window;
              "Mod+Shift+Q".action = quit;

              "Mod+Return".action.spawn = "ghostty";#换成ghosty
              "Mod+G".action.spawn = [
                "ghostty"
                "-e"
                "hx"
              ];
              "Mod+E".action.spawn = [
                "ghostty"
                "-e"
                "yazi"
              ];
              "Mod+W".action.spawn = "firefox";
              "Mod+A".action.spawn = "onagre";


              "Mod+F".action = toggle-window-floating;
              "Mod+B".action = fullscreen-window;
              "Mod+Tab".action = toggle-overview;#概览

              "Mod+H".action = focus-column-left;
              "Mod+L".action = focus-column-right;

              "Mod+Ctrl+H".action = move-column-left;
              "Mod+Ctrl+L".action = move-column-right;

              "Mod+J".action = focus-window-or-workspace-down;
              "Mod+K".action = focus-window-or-workspace-up;
              "Mod+Shift+J".action = consume-or-expel-window-left;
              "Mod+Shift+K".action = consume-or-expel-window-right;
              "Mod+Ctrl+J".action = move-window-down-or-to-workspace-down;
              "Mod+Ctrl+K".action = move-window-up-or-to-workspace-up;

              "Mod+U".action = focus-column-first;
              "Mod+I".action = focus-column-last;
              "Mod+Ctrl+U".action = move-column-to-first;
              "Mod+Ctrl+I".action = move-column-to-last;



              "Mod+C".action = center-column;
              "Mod+V".action = switch-focus-between-floating-and-tiling;
              #"Mod+Shift+v".action = focus-tiling;

              "Mod+Shift+1".action.move-window-to-workspace = 1;
              "Mod+Shift+2".action.move-window-to-workspace = 2;
              "Mod+Shift+3".action.move-window-to-workspace = 3;
              "Mod+Shift+4".action.move-window-to-workspace = 4;
              "Mod+Shift+5".action.move-window-to-workspace = 5;
              "Mod+Shift+6".action.move-window-to-workspace = 6;
              "Mod+Shift+7".action.move-window-to-workspace = 7;
              "Mod+Shift+8".action.move-window-to-workspace = 8;
              "Mod+Shift+9".action.move-window-to-workspace = 9;
              "Mod+Shift+0".action.move-window-to-workspace = 10;

              "Mod+1".action.focus-workspace = 1;
              "Mod+2".action.focus-workspace = 2;
              "Mod+3".action.focus-workspace = 3;
              "Mod+4".action.focus-workspace = 4;
              "Mod+5".action.focus-workspace = 5;
              "Mod+6".action.focus-workspace = 6;
              "Mod+7".action.focus-workspace = 7;
              "Mod+8".action.focus-workspace = 8;
              "Mod+9".action.focus-workspace = 9;
              "Mod+0".action.focus-workspace = 10;

              "Mod+Shift+H".action.set-column-width = "-5%";
              "Mod+Shift+L".action.set-column-width = "+5%";

              "Mod+S".action = screenshot;
            }
            // {
              # Audio
              "XF86AudioRaiseVolume" = {
                allow-when-locked = true;
                action.spawn = [
                  "${pkgs.wireplumber}/bin/wpctl"
                  "set-volume"
                  "@DEFAULT_AUDIO_SINK@"
                  "0.05+"
                ];
              };
              "XF86AudioLowerVolume" = {
                allow-when-locked = true;
                action.spawn = [
                  "${pkgs.wireplumber}/bin/wpctl"
                  "set-volume"
                  "@DEFAULT_AUDIO_SINK@"
                  "0.05-"
                ];
              };
              "XF86AudioMute" = {
                allow-when-locked = true;
                action.spawn = [
                  "${pkgs.wireplumber}/bin/wpctl"
                  "set-mute"
                  "@DEFAULT_AUDIO_SINK@"
                  "toggle"
                ];
              };
              "XF86AudioMicMute" = {
                allow-when-locked = true;
                action.spawn = [
                  "${pkgs.wireplumber}/bin/wpctl"
                  "set-mute"
                  "@DEFAULT_AUDIO_SOURCE@"
                  "toggle"
                ];
              };
            };

          layout = {
            gaps = 16;

            center-focused-column = "on-overflow";

            preset-column-widths = [
              { proportion = 1. / 4.; }
              { proportion = 1. / 3.; }
              { proportion = 1. / 2.; }
              { proportion = 2. / 3.; }
              { proportion = 9. / 10.; }
            ]; # TODO: clicks to PR a docs update for niri-flake
          };

          prefer-no-csd = true; # No "client-side-decorations" (i.e. client-side window open/close buttons)
          hotkey-overlay.skip-at-startup = true;
          screenshot-path = null;

          spawn-at-startup = [
            {
              command = [ "${pkgs.xwayland-satellite}/bin/xwayland-satellite" ];
            }
            {
              command = [
                "${pkgs.swaybg}/bin/swaybg"
                "-i"
                "${config.niri.wallpaper}"
                "-m"
                "fill"
              ];
            }
            {
              command = [
                "${pkgs.swayidle}/bin/swayidle"
                "-w"
                "timeout"
                "300"
                lock
                "timeout"
                "450"
                "niri msg action power-off-monitors"
                "resume"
                "niri msg action power-on-monitors" # Not sure if this is really needed - niri normally powers on monitors on a movement action anyway, but maybe this can affect resuming in different ways?
                "before-sleep"
                lock
              ];
            }
            {
              command = [
                "fcitx5"
                "-dr"
              ];
            }
          ];
        };
      };

    programs.walker.enable = true;

    programs.bash.profileExtra = lib.mkBefore ''
      if [ -z $WAYLAND_DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
        exec ${config.programs.niri.package}/bin/niri-session -l
      fi
    '';

    systemd.user.services.niri = {
      Unit = {
        Description = "A scrollable-tiling Wayland compositor";
        BindsTo = "graphical-session.target";
        Wants = [
          "graphical-session-pre.target"
          "xdg-desktop-autostart.target"
        ];
        After = [
          "graphical-session-pre.target"
          "xdg-desktop-autostart.target"
        ];
      };

      Service = {
        Slice = "session.slice";
        Type = "notify";
        ExecStart = "${config.programs.niri.package}/bin/niri --session";
      };
    };

    systemd.user.services.xdg-desktop-portal = {
      # Overrides the portals from NixOS' `xdg.portal.enable`
      Unit = {
        Description = "Portal service";
        PartOf = "graphical-session.target";
        Requires = "dbus.service";
        After = [
          "dbus.service"
          "niri.service"
        ];
      };

      Service = {
        Type = "dbus";
        BusName = "org.freedesktop.portal.Desktop";
        ExecStart = "${pkgs.xdg-desktop-portal}/libexec/xdg-desktop-portal";
        Slice = "session.slice";
      };
    };
  };
}
