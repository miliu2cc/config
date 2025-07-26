# SPDX-FileCopyrightText: 2025 FreshlyBakedCake
#
# SPDX-License-Identifier: MIT

{ config, ... }:
let
  nixpkgs = config.inputs.nixpkgs.result;
in
{
  config.homes."n3xt2f:x86_64-linux" = {
    modules = [
      {
        home.stateVersion = "25.05";
        home.homeDirectory = "/home/n3xt2f";
      }
      (import ./catppuccin { inherit (config.inputs) catppuccin; })
      ./common
      ./development
      #./gaming
      ./n3xt2f
      ./waybar
      (import ./niri { inherit (config.inputs) niri walker home-manager-unstable; })
      (import ./nix-index { inherit (config.inputs) nix-index-database; })
      #./remote
    ];
    args = {
      system = "x86_64-linux";
      project = config;
    };
  };
}
