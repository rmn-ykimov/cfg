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
      "darktable"
      "gimp"

    ];

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };
    
  };
}
