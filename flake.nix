{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/master";
    home-manager = {
       url = "github:nix-community/home-manager";
       inputs.nixpkgs.follows = "nixpkgs";
     };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, nixpkgs-stable, ... }@inputs:
    let
          system = "x86_64-linux";
          pkgs = nixpkgs.legacyPackages.${system};
	  unstable-pkgs = nixpkgs-stable.legacyPackages.${system};
   in
   {
    nixosConfigurations.hydrangea = nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      
      modules = [
        ./configuration.nix
        inputs.home-manager.nixosModules.default
	inputs.nixvim.nixosModules.nixvim
      ];
      environment.systemPackages = [ unstable-pkgs.tor-browser ];
    };
  };
}
