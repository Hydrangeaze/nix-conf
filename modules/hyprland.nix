{ pkgs, ... }:
{
  services.xserver = {
	xkb.layout = "us, ru";
	xkb.options = "grp:alt_shift_toggle";
	enable = true;
  };
  services.displayManager.sddm = {
  	enable = true;
  	wayland.enable = true;
  	theme = "where-is-my-sddm-theme";
  };

  programs.hyprland = {
	enable = true;
	xwayland.enable = true;	
	portalPackage = pkgs.xdg-desktop-portal-hyprland;
  };
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
	    xdg-desktop-portal-gtk
    ];
    config.common.default = "gtk";
  };
}
