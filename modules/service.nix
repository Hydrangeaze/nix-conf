{ pkgs, ...}:{
  services.tor = {
    enable = true;
    enableGeoIP = false;
  };
}
