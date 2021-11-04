{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-21.05";
    welteki-nix.url = "github:welteki/welteki.nix";
    deploy-rs.url = "github:serokell/deploy-rs";
  };

  outputs = inputs@{ self, nixpkgs, deploy-rs, ... }:
  let 
    system = "x86_64-linux";
  in
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        inputs.welteki-nix.nixosModules.hetzner-cloud
        inputs.welteki-nix.nixosModules.common
        inputs.welteki-nix.nixosModules.welteki-users
      ];
    };

    deploy.nodes.nixos = {
      hostname = "localhost";
        profiles.system.user = "root";
        profiles.system.path =
          deploy-rs.lib.${system}.activate.nixos self.nixosConfigurations.nixos;
    };
  };
}
