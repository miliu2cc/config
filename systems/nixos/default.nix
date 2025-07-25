# SPDX-FileCopyrightText: 2025 FreshlyBakedCake
#
# SPDX-License-Identifier: MIT

{ config, lib, pkgs, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./hostname.nix
  ];

  # Enable NetworkManager
  networking.networkmanager.enable = true;


  # Define a user account
  users.users.n3xt2f = {
    isNormalUser = true;
    description = "n3xt2f";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.nushell;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  system.stateVersion = "25.05";
}
