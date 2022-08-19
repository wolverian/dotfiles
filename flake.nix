{ 
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "aarch64-linux";
      home = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.antti = {
              imports = [(import ./home.nix)];
            };
          }
        ];
      };
      work = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./desktop.nix
          ./configuration.nix
          home-manager.nixosModules.home-manager {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.antti = {
              imports = [(import ./home.nix)];
            };
          }
        ];
      };
    in {
      nixosConfigurations = {
        inherit home work;
      };
    };
}
