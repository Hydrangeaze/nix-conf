  #HOME_MANAGER
  { config, pkgs, lib , ... }:
  let
    user = "hydrangea";
  in
  {
    home.stateVersion = "23.11"; 

    home.file.".p10k.zsh" = {
      source = ./dots/p10k/p10k.zsh;
      executable = true;
    };
    home.file.".config/dunst/dunstrc".source = ./dots/dunst/dunstrc;
    home.file.".config/tofi/config".source = ./dots/tofi/config;
    home.file.".config/waybar/config".source = ./dots/waybar/config;
    home.file.".config/waybar/icon/furudo.jpg".source = ./dots/waybar/icon/furudo.jpg;
    home.file.".config/waybar/style.css".source = ./dots/waybar/style.css;
    home.file.".config/alacritty/alacritty.toml".source = ./dots/alacritty/alacritty.toml;
    home.file.".config/hypr/hyprland.conf".source = ./dots/hypr/hyprland.conf;
    home.file.".config/hypr/hypridle.conf".source = ./dots/hypr/hypridle.conf;
    home.file.".config/hypr/hyprpaper.conf".source = ./dots/hypr/hyprpaper.conf;
    home.file.".config/hypr/wallpaper/1.jpg".source = ./dots/hypr/wallpaper/1.jpg;
    home.file.".config/hypr/config-sh/r_waybar.sh".source = ./dots/hypr/config-sh/r_waybar.sh;
    home.file.".config/hypr/config-sh/startup-hypr.sh".source = ./dots/hypr/config-sh/startup-hypr.sh;
    home.file.".config/nixpkgs/config.nix".source = ./dots/nixpkgs/config.nix;
    home.file.".config/fastfetch/config.jsonc".source = ./dots/fastfetch/config.jsonc;
    home.file.".config/fastfetch/logos/erika_256.png".source = ./dots/fastfetch/logos/erika_256.png;
    home.file.".config/kitty/kitty.conf".source = ./dots/kitty/kitty.conf; 

    home.activation = {
      # https://github.com/philj56/tofi/issues/115#issuecomment-1701748297
      regenerateTofiCache = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        tofi_cache=${config.xdg.cacheHome}/tofi-drun
        [[ -f "$tofi_cache" ]] && rm "$tofi_cache"
      '';
    };
    
    xdg.desktopEntries = {
#    	discord = {
#    		name = "Discord";
#    		genericName = "idk video messenger";
#    		exec = "discord  --enable-features=UseOzonePlatform --ozone-platform=wayland"; 	
#    		terminal = false;
#    	};	
	nvim = {
	   name = "Nvim";
	   genericName = "neovim in terminal";
	   exec = "kitty -e neovim";
	   terminal = true;
	};
    };
    
    gtk.enable = true;
    gtk.theme.package = pkgs.graphite-gtk-theme;
    gtk.theme.name = "Graphite-Dark";
    gtk.cursorTheme.package = pkgs.bibata-cursors;
    gtk.cursorTheme.name = "Bibata-Modern-Ice";
    
    programs.obs-studio = {
    	enable = true;
    	plugins = with pkgs.obs-studio-plugins; [
    		wlrobs
    		obs-backgroundremoval
    		obs-pipewire-audio-capture
    	];
    };
    
    programs.alacritty.enable = true;
	
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        ll = "ls -l";
        update = "sudo nixos-rebuild switch --flake /home/${user}/.config/nixos/.#hydrangea";
        nix-conf = "sudo nvim $HOME.config/nixos/configuration.nix";
        hypr-conf = "nvim $HOME/.config/nixos/dots/hypr/hyprland.conf";
        wayb-conf = "nvim $HOME/.config/nixos/dots/waybar/config";
      };

	  initExtra = ''
        [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
      '';

      zplug = {
        enable = true;
        plugins = [
          { name = "zsh-users/zsh-autosuggestions"; } 
          { name = "romkatv/powerlevel10k"; tags = [ "as:theme" "depth:1" ]; } # Corrected punctuation here
        ];
      };
    };
    
  }
