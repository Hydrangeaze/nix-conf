{ config, pkgs, inputs, ... }:

let
  user = "hydrangea";
in
{
  imports =
    [
      ./hardware-configuration.nix
      inputs.home-manager.nixosModules.default
      ./modules/nvim/nvim-modules.nix
      ./modules/service.nix
      ./modules/systemd.nix
      ./modules/tor.nix
      ./modules/laptop/power_managment.nix
      ./modules/laptop/hardware.nix
      ./modules/laptop/bluetooth.nix
      ./modules/audio.nix
      ./modules/udev.nix
      ./modules/hyprland.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.configurationLimit = 10;
  boot.loader.timeout = 5;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  
  nix.optimise.automatic = true;
  nix.optimise.dates = [ "16:00" ];

  networking.hostName = "nixos";
  networking.networkmanager.insertNameservers = [ "1.1.1.1" "8.8.8.8" ]; 
  networking.networkmanager.enable = true; #this 

  time.timeZone = "Europe/Moscow";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  environment.pathsToLink = [ "/libexec" ];

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      (nerdfonts.override { fonts = [ "Iosevka" "JetBrainsMono" ]; })
      fira-code
      fira-code-symbols
      font-awesome
      liberation_ttf
      mplus-outline-fonts.githubRelease
      nerdfonts
      noto-fonts
      noto-fonts-emoji
      ubuntu_font_family
      vazir-fonts
    ];
  };
  
  environment.sessionVariables = {
  #NIXOS_OZONE_WL = "1";
  WLR_NO_HARDWARE_CURSORS = "1";
  RIDER_VM_OPTIONS = "/home/hydrangea/Application/jetbrains/crack/rider64.vmoptions"; 
  };
    

  hardware.opentabletdriver.enable = true;

  services.printing.enable = true;
  services.libinput.enable = true;
 users.defaultUserShell = pkgs.zsh; programs.zsh.shellInit = "fastfetch"; environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;

  users.users.${user} = {
    isNormalUser = true;
    description = "hydrangea";
    extraGroups = [ "networkmanager" "wheel" "video" ];
		#packages = with pkgs; [
		#];
  };

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  security.pam.services.gdm.enableGnomeKeyring = true;
  services.gnome.gnome-keyring.enable = true;
  systemd.tmpfiles.rules = [
  
      "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
    ];
  
  nixpkgs.config.allowUnfree = true;
   virtualisation.virtualbox.host.enable = true;
   users.extraGroups.vboxusers.members = [ "${user}" ]; 


	#virtualisation.docker.enable = true;

  services.gvfs.enable = true;



  environment.systemPackages = with pkgs; [
    #MAIN 
    	virtualbox
	htop
	alacritty
	anki-bin
	telegram-desktop
	mpv
	rustup
	curl
	distrobox
	hwinfo
	wget
	jmtpfs
	spotdl
	gvfs
	git
	freetube
	tor-browser
	signal-desktop
	osu-lazer-bin
	lshw-gui
	openssl_3_3
	teamspeak5_client
	brave
	aircrack-ng
	genymotion
	android-tools
	twitch-dl
	zoom-us
	zip
	librewolf
	element-desktop-wayland
	toybox
	ventoy-full
	syncthing
	fastfetch
	rpm
	cpio
	zsh
	xfce.thunar-volman
	keepassxc
	gparted
	unityhub
	#jetbrains.rider
	dotnet-sdk_8	
	dotnet-runtime_8
	dotnet-aspnetcore_8
	dotnetPackages.Nuget
	msbuild
	opentabletdriver
	ffmpeg
	alsa-lib
	playerctl
	qbittorrent-qt5
	zplug
	steam
	blender-hip
	blueman
	obs-studio
	v2ray
	gh
	xwayland
	bluez5-experimental 
	bluez-tools
	bluez-alsa
	bluetuith
	yt-dlp-light
	spotify
	evince
	libsForQt5.qt5.qtwayland
	libsForQt5.qt5ct
	armcord
	foliate
	upower
	qt6.qtwayland
	xfce.thunar
	wireguard-tools
	grimblast
	python3
	krita
	imv
	unzip
	p7zip
	bottles
	#pureref
	#OPTIONAL
	waybar-mpris
	ani-cli
	#Hyprland
	wireplumber
	xdg-desktop-portal-hyprland
	xdg-desktop-portal-gtk
	kitty
	pavucontrol
	rofi
	emacsPackages.alsamixer
	hyprpaper
	gnome-keyring
	libsecret
	tofi
	hyprland
	xdg-desktop-portal-wlr
	dunst
	hyprpicker
	swww
	libnotify
	w3m
	imagemagick
	xdotool
	networkmanagerapplet
	hypridle
	(waybar.overrideAttrs (oldAttrs: {
		mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];	
	}))
	wl-color-picker
        wl-clipboard
  ];
  
  system.stateVersion = "23.11"; # Did you read the comment?

  #HOME_MANAGER
  home-manager = {
  	extraSpecialArgs = { inherit inputs; };
  	users = {
  		"hydrangea" = import ./home.nix;
  	};
  };

  #FLAKES
   nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
}
