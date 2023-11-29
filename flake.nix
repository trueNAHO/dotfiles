{
  description = "NAHO's Home Manager configuration";

  inputs = {
    # Add the 'beautysh' input for consistent versioning across inputs.
    beautysh = {
      inputs = {
        nixpkgs.follows = "nixpkgs";
        utils.follows = "flakeUtils";
      };

      url = "github:lovesegfault/beautysh";
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

    flakeUtils.url = "github:numtide/flake-utils";

    homeManager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim = {
      inputs = {
        beautysh.follows = "beautysh";
        flake-utils.follows = "flakeUtils";
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks.follows = "preCommitHooks";
      };

      url = "github:trueNAHO/nixvim/feat-plugins-languages-debugprint";
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
        checks.preCommitHooks = preCommitHooks.lib.${system}.run {
          hooks = {
            alejandra.enable = true;
            convco.enable = true;
            typos.enable = true;
            yamllint.enable = true;
          };

          settings.alejandra.verbosity = "quiet";
          src = ./.;
        };

        devShells.default = pkgs.mkShell {
          inherit (self.checks.${system}.preCommitHooks) shellHook;
        };
      }
    )
    // import ./hosts {inherit inputs;};
}
