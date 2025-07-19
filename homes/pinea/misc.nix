# SPDX-FileCopyrightText: 2025 FreshlyBakedCake
#
# SPDX-License-Identifier: MIT

{ pkgs, ... }:
{
  # Miscellaneous package installs that aren't really big enough to get their own folder
  # Don't place any config that isn't directly adding lines to home.packages here...
  home.packages = [
    pkgs.obs-studio
    pkgs.vlc
    pkgs.python312
    pkgs.playerctl
    pkgs.bun
    pkgs.nodePackages_latest.nodejs
    pkgs.prusa-slicer
    pkgs.kitty
  ];
}
