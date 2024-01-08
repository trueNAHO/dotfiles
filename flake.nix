{
  description = "NAHO's dofiles managed with Home Manager";

  inputs = {
    agenix = {
      inputs = {
        home-manager.follows = "homeManager";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };

      url = "github:ryantm/agenix";
    };

    dragonXplr = {
      flake = false;
      url = "github:sayanarijit/dragon.xplr";
    };

    # Add the 'flakeCompat' input for consistent versioning across inputs.
    flakeCompat = {
      flake = false;
      url = "github:edolstra/flake-compat";
    };

    flakeUtils = {
      inputs.systems.follows = "systems";
      url = "github:numtide/flake-utils";
    };

    homeManager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };

    nix-alien = {
      inputs = {
        flake-compat.follows = "flakeCompat";
        flake-utils.follows = "flakeUtils";
        nixpkgs.follows = "nixpkgs";
      };

      url = "github:thiagokokada/nix-alien";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim = {
      inputs = {
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks.follows = "preCommitHooks";
      };

      url = "github:nix-community/nixvim";
    };

    preCommitHooks = {
      inputs = {
        flake-compat.follows = "flakeCompat";
        flake-utils.follows = "flakeUtils";
        nixpkgs-stable.follows = "preCommitHooks/nixpkgs";
        nixpkgs.follows = "nixpkgs";
      };

      url = "github:cachix/pre-commit-hooks.nix";
    };

    stylix = {
      inputs = {
        flake-compat.follows = "flakeCompat";
        home-manager.follows = "homeManager";
        nixpkgs.follows = "nixpkgs";
      };

      url = "github:danth/stylix";
    };

    # Add the 'systems' input for consistent versioning across inputs.
    systems.url = "github:nix-systems/default";

    triPaneXplr = {
      flake = false;
      url = "github:sayanarijit/tri-pane.xplr";
    };
  };

  outputs = {
    self,
    flakeUtils,
    nixpkgs,
    preCommitHooks,
    ...
  } @ inputs:
    flakeUtils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        checks = {
          homeManager = self.homeConfigurations.${system}.activationPackage;

          preCommitHooks = preCommitHooks.lib.${system}.run {
            hooks = {
              alejandra.enable = true;
              convco.enable = true;
              typos.enable = true;
              yamllint.enable = true;
            };

            settings.alejandra.verbosity = "quiet";
            src = ./.;
          };
        };

        devShells.default = pkgs.mkShell {
          inherit (self.checks.${system}.preCommitHooks) shellHook;
        };
      }
    )
    // import ./hosts {inherit inputs;};
}
