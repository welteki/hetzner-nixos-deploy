{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
    welteki-nix.url = "github:welteki/welteki.nix";
  };

  outputs = inputs@{ self, nixpkgs, ... }: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.welteki-nix.nixosModules.hetzner-cloud
        inputs.welteki-nix.nixosModules.common
        inputs.welteki-nix.nixosModules.welteki-users
      ];
    };
  };
}
