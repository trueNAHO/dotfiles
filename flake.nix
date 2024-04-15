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
      # The 'nix-index-database' and 'nixpkgs' inputs are not overridden to
      # prevent version mismatches:
      #
      # > Overriding 'nix-alien' inputs may cause mismatches between the
      # > 'nix-index-database' and 'nixpkgs', causing possibly incorrect
      # > results, so it is unsupported.
      # >
      # > (Source:
      # > https://github.com/thiagokokada/nix-alien/blob/75c0c2d5eb1fdd2c5187c49888cab40b060605fa/README.md#nixos-installation-with-flakes)
      inputs = {
        flake-compat.follows = "flakeCompat";
        flake-utils.follows = "flakeUtils";
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
    # The 'outputs.homeConfigurations' attribute set is not contained in
    # 'inputs.flakeUtils.lib.eachDefaultSystem' to prevent the following invalid
    # 'system' key injection:
    #
    #     outputs.homeConfigurations.${system}.<HOME_CONFIGURATION_NAME>
    #
    # Due to the more reliable 'pkgs.lib.mkMerge' function being unavailable,
    # the 'inputs.flakeUtils.lib.defaultSystems' expression and
    # 'outputs.homeConfigurations' attribute set are merged using the '//'
    # operator.
    #
    # Unlike 'inputs.flakeUtils.lib.eachDefaultSystem', this implementation
    # merely provides the 'system' argument.
    // {
      homeConfigurations =
        builtins.foldl'
        (
          acc: system: let
            pkgs = inputs.nixpkgs.legacyPackages.${system};
          in
            acc // (import ./home_configurations {inherit inputs pkgs system;})
        )
        {}
        inputs.flakeUtils.lib.defaultSystems;
    };
}
