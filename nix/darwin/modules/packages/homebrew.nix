{ config, pkgs, ... }:

{

  homebrew = {
    enable = true;
    casks = [

      "ghostty"
      "jupyterlab"
      "vlc"
      "godot"
      "amneziavpn"

    ];

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    
  };
}
