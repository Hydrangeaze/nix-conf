{ pkgs, ...}:
{
  systemd.user.services.mpris-proxy = {
      description = "Mpris proxy";
      after = [ "network.target" "sound.target" ];
      wantedBy = [ "default.target" ];
      serviceConfig.ExecStart = "${pkgs.bluez}/bin/mpris-proxy";
  };

  systemd.user.services.nm-applet = {
	after = [ "network.target" ];
  	serviceConfig.ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
  	wantedBy = [ "default.target" ];
  	
  };

  systemd.oomd.enable = true;
}
