{ config, pkgs, ... }:

{

  homebrew = {
    enable = true;
    casks = [
      "ghostty"
      "vlc"
      "godot-mono"
      "blender"
      "dotnet-sdk"
    ];

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    
  };
}
