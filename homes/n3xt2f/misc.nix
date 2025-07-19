# SPDX-FileCopyrightText: 2025 FreshlyBakedCake
#
# SPDX-License-Identifier: MIT

{ config, lib, pkgs, ... }:
{
  # Desktop environment packages
  home.packages = with pkgs; [
    # File manager
    yazi
    
    # Media
    vlc
    
    # Image viewer
    eog
    
    # PDF viewer
    evince
    wechat-uos
  ];

  # XDG configuration
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };
  };
}