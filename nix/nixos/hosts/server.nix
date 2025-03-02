{
  system.stateVersion = "24.11";

  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "/dev/vda" ];

  services.cloud-init.enable = true;
  services.cloud-init.network.enable = true;

  networking.useDHCP = false;

}
