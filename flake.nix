{
  description = "NixOS configuratie";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
  };

  outputs = { self, nixpkgs, ... }: {
    nixosConfigurations.nixvm = nixpkgs.lib.nixosSystem {
      modules = [ ./hosts/nixvm/configuration.nix ];
    };
  };
}
