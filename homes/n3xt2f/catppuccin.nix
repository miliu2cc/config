# SPDX-FileCopyrightText: 2025 FreshlyBakedCake
#
# SPDX-License-Identifier: MIT

{ config, lib, pkgs, ... }:
{
  # Catppuccin theme configuration
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
  };

  # GTK theme
  gtk = {
    enable = true;
    catppuccin = {
      enable = true;
      flavor = "mocha";
      accent = "blue";
      size = "standard";
      tweaks = [ "rimless" ];
    };
  };

  # Qt theme
  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";
  };

  # Kvantum theme
  qt.style.catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "blue";
  };
}