{ pkgs, ...}:
{
  hardware.bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez5-experimental;
      settings.General.Enable = "Source,Sink,Media,Socket";
   };
   services.blueman.enable = true;
}
