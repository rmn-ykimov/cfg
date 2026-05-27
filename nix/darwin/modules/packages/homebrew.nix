{ config, pkgs, ... }:

{

  homebrew = {
    enable = true;
    casks = [

      "ghostty"
      #"jupyterlab"
      "vlc"
      "godot"
      #"amneziavpn"
      "darktable"
      #"gimp"
      "google-chrome"
      "obsidian"
      "zotero"

    ];

    onActivation = {
      cleanup = "zap";
      autoUpdate = true;
      upgrade = true;
    };

  };
}
