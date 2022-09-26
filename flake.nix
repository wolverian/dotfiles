{ 
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      overlays = [
        inputs.neovim-nightly-overlay.overlay
      ];
      user = "antti";
      system = "aarch64-linux";
      home = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit user; };
        modules = [
          ./hosts/vm/configuration.nix
          {
            nixpkgs.overlays = overlays;
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit user; };
            home-manager.users.${user} = {
              imports = [(import ./home.nix)];
            };
          }
        ];
      };
      work = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit user; };
        modules = [
          ./hosts/vm/configuration.nix
          ./modules/desktop.nix
          {
            nixpkgs.overlays = overlays;
          }
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit user; };
            home-manager.users.${user} = {
              imports = [(import ./home.nix)] ++ [(import ./hosts/work/home.nix)];
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
