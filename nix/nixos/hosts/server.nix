{
  system.stateVersion = "24.11";

  fileSystems."/" = {
    device = "/dev/vda1";
    fsType = "ext4";
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "/dev/vda" ];

  systemd.network.wait-online.enable = false;

  networking.useDHCP = false;

  services.cloud-init.enable = true;
  services.cloud-init.network.enable = true;

  services.cloud-init.settings.datasource_list = [ "ConfigDrive" ];

  services.cloud-init.settings.boot.wait_for_network = { enabled = false; };

}
