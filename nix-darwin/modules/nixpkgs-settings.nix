{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
