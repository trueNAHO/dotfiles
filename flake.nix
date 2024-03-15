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
        home-manager.follows = "homeManager";
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

  outputs = inputs:
    inputs.flakeUtils.lib.eachDefaultSystem (
      system: let
        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in {
        checks =
          builtins.mapAttrs
          (_: homeConfiguration: homeConfiguration.activationPackage)
          (
            pkgs.lib.filterAttrs
            (
              homeConfigurationName: _:
                pkgs.lib.hasPrefix system homeConfigurationName
            )
            inputs.self.homeConfigurations
          )
          // {
            inherit (inputs.self.packages.${system}) docs;

            preCommitHooks = inputs.preCommitHooks.lib.${system}.run {
              hooks = {
                alejandra.enable = true;
                convco.enable = true;
                typos.enable = true;
                yamllint.enable = true;
              };

              settings = {
                alejandra.verbosity = "quiet";
                typos.exclude = "*.age";
              };

              src = ./.;
            };
          };

        devShells.default = pkgs.mkShell {
          inherit (inputs.self.checks.${system}.preCommitHooks) shellHook;

          packages = [
            inputs.agenix.packages.${system}.default
            inputs.homeManager.packages.${system}.default
          ];
        };

        packages.docs = let
          out = "${placeholder "out"}/usr/share/doc";
        in
          pkgs.stdenv.mkDerivation {
            buildPhase = ''
              asciidoctor-multipage \
                --attribute attribute-missing=warn \
                --destination-dir "${out}" \
                --failure-level INFO \
                index.adoc
            '';

            name = "docs";
            nativeBuildInputs = [pkgs.asciidoctor-with-extensions];
            src = ./docs;
          };
      }
    )
    // {
      homeConfigurations =
        builtins.foldl'
        (
          acc: system: let
            pkgs = inputs.nixpkgs.legacyPackages.${system};
          in
            acc
            // pkgs.lib.mapAttrs'
            (
              homeConfigurationName: homeConfiguration:
                pkgs.lib.nameValuePair
                "${system}-${homeConfigurationName}"
                homeConfiguration
            )
            (
              builtins.foldl' (
                acc: file: acc // (import file {inherit inputs pkgs system;})
              ) {} (import ./home_configurations)
            )
        )
        {}
        inputs.flakeUtils.lib.defaultSystems;
    };
}
