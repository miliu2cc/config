# SPDX-FileCopyrightText: 2025 FreshlyBakedCake
#
# SPDX-License-Identifier: MIT

{ config, ... }:
let
  nixpkgs = config.inputs.nixpkgs.result;
in
{
  config.systems.nixos."nixos" = {
    pkgs = nixpkgs.x86_64-linux;
    modules = [
      ./common
      ./gnome
      ./niri
      ./nixos
      ./personal
      ./river
    ];
    args = {
      system = "x86_64-linux";
      project = config;
    };
    homes = { inherit (config.homes) "n3xt2f:x86_64-linux"; };
  };
}
