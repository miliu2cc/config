# SPDX-FileCopyrightText: 2025 FreshlyBakedCake
#
# SPDX-License-Identifier: MIT

{ config, lib, pkgs, ... }:
{
  imports = [
    ./catppuccin.nix
    ./misc.nix
    ./niri.nix
  ];

  # Basic home configuration
  home.username = "n3xt2f";
  home.homeDirectory = "/home/n3xt2f";

  # Enable home-manager
  programs.home-manager.enable = true;

  # Git configuration
  programs.git = {
    enable = true;
    userName = "n3xt2f";
    userEmail = "n3xt2f@gmail.com"; # Replace with actual email
  };

  # Basic shell configuration
  programs.bash.enable = true;
  programs.nushell.enable = true;

  # Basic packages
  home.packages = with pkgs; [
    firefox
    git
    vim
    htop
    tree
    wget
    curl
  ];
}