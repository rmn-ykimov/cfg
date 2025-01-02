{ config, pkgs, ... }:

{
  system.defaults = {

    dock = {
        autohide = true;
        show-recents = false;
        launchanim = true;
        orientation = "bottom";
        tilesize = 65;
      };

    SoftwareUpdate = {
      AutomaticallyInstallMacOSUpdates = true;
      };
    
    magicmouse = {
      MouseButtonMode = "OneButton";
    };

  };
}
