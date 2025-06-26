{ config, pkgs, ... }:

{

  homebrew = {
    enable = true;
    casks = [

      "ghostty"
      "jupyterlab"
      "vlc"
      "godot"

    ];

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    
  };
}
