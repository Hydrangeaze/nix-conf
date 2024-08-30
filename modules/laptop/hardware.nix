{ pkgs, ...}:
{
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];
  hardware.graphics = {
    extraPackages = with pkgs; [
      rocmPackages.clr.icd
      amdvlk
	 driversi686Linux.amdvlk
    ];
    enable32Bit = true;
  };
}
