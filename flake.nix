{
  description = "NAHO's dofiles managed with Home Manager";

  inputs = {
    agenix = {
      inputs = {
        darwin.follows = "nixDarwin";
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

    # This input ensures consistent versioning across inputs.
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
      # > -- https://github.com/thiagokokada/nix-alien/blob/75c0c2d5eb1fdd2c5187c49888cab40b060605fa/README.md#nixos-installation-with-flakes
      inputs = {
        flake-compat.follows = "flakeCompat";
        flake-utils.follows = "flakeUtils";
      };

      url = "github:thiagokokada/nix-alien";
    };

    # This input ensures consistent versioning across inputs.
    nixDarwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:lnl7/nix-darwin";
    };

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim = {
      inputs = {
        flake-compat.follows = "flakeCompat";
        home-manager.follows = "homeManager";
        nix-darwin.follows = "nixDarwin";
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

    # This input ensures consistent versioning across inputs.
    systems.url = "github:nix-systems/default";

    triPaneXplr = {
      flake = false;
      url = "github:sayanarijit/tri-pane.xplr";
    };
  };

  outputs = inputs:
    inputs.flakeUtils.lib.eachDefaultSystem (
      system: let
        lib = pkgs.lib.extend (
          final: _:
            import ./lib {
              inherit inputs pkgs system;
              lib = final;
            }
        );

        nixosOptionsDoc = {
          nixosOptionsDoc = let
            options =
              (
                let
                  name = "nixos-options-doc";
                in
                  # TODO: Avoid Import From Derivation (IFD) by extracting the
                  # options without intermediate derivations.
                  (
                    lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration
                    name
                    # The lacking 'config' attribute prevents evaluating
                    # full-blown Home Manager derivations, which increases
                    # performance and compatibility by not evaluating
                    # derivations for non-native architectures.
                    {
                      imports = [home_configurations/private/full/imports.nix];
                    }
                  )
                  .${name}
              )
              .options
              .dotfiles;
          in
            extraConfig:
              pkgs.nixosOptionsDoc (extraConfig {
                # This attribute set is expected contain all internal module
                # options.
                inherit options;
              });

          transformOptions = {
            declarations.documentation = let
              declarationPrefix = toString ./.;
            in
              option: {
                declarations =
                  map
                  (
                    declaration: let
                      declarationString = toString declaration;

                      declarationWithoutprefix =
                        lib.removePrefix
                        "${declarationPrefix}/"
                        declarationString;
                    in
                      if lib.hasPrefix declarationPrefix declarationString
                      then {
                        name = "<dotfiles/${declarationWithoutprefix}/default.nix>";
                        url = "https://github.com/trueNAHO/dotfiles/blob/master/${declarationWithoutprefix}/default.nix";
                      }
                      else
                        throw
                        "declaration not in ${declarationPrefix}: ${declarationString}"
                  )
                  option.declarations;
              };

            visible.bool = option: {
              visible = option.visible && option.type == "boolean";
            };
          };
        };

        pkgs = inputs.nixpkgs.legacyPackages.${system};
      in {
        checks =
          # This set automatically generates
          # 'inputs.self.checks.<SYSTEM>.standalone-<OPTION>-<VALUE>' Home
          # Manager activation packages based on internal module options.
          (
            builtins.mapAttrs
            (_: value: value.activationPackage)
            (
              let
                homeManagerConfiguration = optionName: optionValue: let
                  path = lib.splitString separator optionName;
                  separator = ".";
                in
                  lib.dotfiles.homeManagerConfiguration.homeManagerConfiguration
                  (
                    builtins.concatStringsSep
                    lib.dotfiles.homeManagerConfiguration.separator
                    (
                      ["standalone"]
                      ++ lib.drop 1 path
                      ++ [(lib.boolToString optionValue)]
                    )
                  )
                  (
                    # Due to the following error, the list of attribute sets is
                    # merged using 'lib.dotfiles.recursiveMerge' instead of
                    # 'lib.mkMerge':
                    #
                    #     error: Module `:anon-1:anon-1' has an unsupported
                    #     attribute `_type'. This is caused by introducing a
                    #     top-level `config' or `options' attribute. Add
                    #     configuration attributes immediately on the top level
                    #     instead, or move all of them (namely: _type contents)
                    #     into the explicit `config' attribute.
                    lib.dotfiles.recursiveMerge
                    # Backtrack the 'optionName' attribute set to declare itself
                    # and potentially necessary parent options to the same
                    # value.
                    #
                    # For example, the 'a.b.c.d.full' option would declare
                    # itself and the following options, if available, to the
                    # same value, while importing their necessary dependencies:
                    #
                    #     - a.b.c.d.enable
                    #     - a.b.c.enable
                    #     - a.b.enable
                    #     - a.enable
                    #
                    # The backtracking only considers 'enable' options to
                    # provide minimal working examples, while enabling
                    # potentially necessary parent modules.
                    (
                      map
                      (
                        option: let
                          name = builtins.concatStringsSep separator option;
                        in
                          lib.optionalAttrs
                          (options ? ${name})
                          (
                            lib.setAttrByPath (["config"] ++ option) optionValue
                            // {
                              imports =
                                lib.flatten
                                options.${name}.declarations;
                            }
                          )
                      )
                      (
                        [path]
                        ++ lib.fix
                        (
                          self: count: list:
                            [(lib.take count list ++ ["enable"])]
                            ++ (
                              if count > 1
                              then self (count - 1) list
                              else []
                            )
                        )
                        (builtins.length path - 1)
                        path
                      )
                    )
                  );

                options =
                  (nixosOptionsDoc.nixosOptionsDoc (
                    parent:
                      parent
                      // {
                        # Extract boolean options as their entire space ('false'
                        # and 'true') can be trivially covered.
                        #
                        # Covering non-boolean options is non-trivial as they
                        # may impose arbitrary constraints on themselves.
                        transformOptions = option:
                          option
                          // nixosOptionsDoc.transformOptions.visible.bool
                          option;
                      }
                  ))
                  .optionsNix;
              in
                lib.concatMapAttrs
                (
                  name: _:
                    (homeManagerConfiguration name false)
                    // (homeManagerConfiguration name true)
                )
                options
            )
          )
          # To maintain performance, this set should not contain composed or
          # aliased packages.
          // inputs.self.packages.${system}
          // lib.mapAttrs'
          (
            name: value:
              lib.nameValuePair
              (
                lib.removePrefix
                "${system}${lib.dotfiles.homeManagerConfiguration.separator}"
                name
              )
              value.activationPackage
          )
          (
            lib.filterAttrs
            (name: _: lib.hasPrefix system name)
            inputs.self.homeConfigurations
          )
          // {
            preCommitHooks = inputs.preCommitHooks.lib.${system}.run {
              hooks = {
                alejandra = {
                  enable = true;
                  settings.verbosity = "quiet";
                };

                convco.enable = true;
                deadnix.enable = true;

                typos = {
                  enable = true;
                  settings.exclude = "*.age";
                };

                yamllint.enable = true;
              };

              src = ./.;
            };
          };

        devShells.default = pkgs.mkShell {
          inherit (inputs.self.checks.${system}.preCommitHooks) shellHook;

          packages = with inputs; [
            agenix.packages.${system}.default
            homeManager.packages.${system}.default
            self.checks.${system}.preCommitHooks.enabledPackages
          ];
        };

        packages.docs = let
          out = "${placeholder "out"}/usr/share/doc";
        in
          pkgs.stdenv.mkDerivation {
            buildPhase = let
              checkDerivations =
                (
                  nixosOptionsDoc.nixosOptionsDoc (
                    parent:
                      parent
                      // {
                        # Due to context loss and expansion restrictions, these
                        # 'options' transformations cannot be done in the
                        # 'transformOptions' function.
                        options =
                          lib.mapAttrsRecursiveCond
                          # Leaves are determined under the assumption that
                          # option attribute sets contain at least one attribute
                          # that is not an attribute set.
                          (
                            value:
                              builtins.all lib.isAttrs (lib.attrValues value)
                          )
                          (
                            let
                              extraConfig = path: value: bool: let
                                boolString = lib.boolToString bool;
                              in {
                                description = builtins.concatStringsSep " " [
                                  "Standalone Home Manager configuration,"
                                  "setting the"
                                  "`${builtins.concatStringsSep "." path}`"
                                  "option and its parent `enable` options to"
                                  "`${boolString}`."
                                ];

                                loc =
                                  ["standalone"]
                                  ++ lib.drop 1 value.loc
                                  ++ [boolString];
                              };
                            in
                              path: value: {
                                false = value // extraConfig path value false;
                                true = value // extraConfig path value true;
                              }
                          )
                          parent.options;

                        transformOptions = option:
                          option
                          // (
                            nixosOptionsDoc.transformOptions.declarations.documentation
                            option
                          )
                          # This attribute set should match the one used to
                          # generate the
                          # 'inputs.self.checks.<SYSTEM>.standalone-<OPTION>-<VALUE>'
                          # Home Manager activation packages.
                          // (
                            nixosOptionsDoc.transformOptions.visible.bool
                            option
                          )
                          // {
                            default = {};
                            example = {};
                            type = {};
                          };
                      }
                  )
                )
                .optionsAsciiDoc;

              moduleOptions =
                (
                  nixosOptionsDoc.nixosOptionsDoc (
                    parent:
                      parent
                      // {
                        transformOptions = option:
                          option
                          // (
                            nixosOptionsDoc.transformOptions.declarations.documentation
                            option
                          );
                      }
                  )
                )
                .optionsAsciiDoc;

              sed = let
                sed = let
                  header = type: title: ''^\/\/ -----${type} ${title}-----$'';
                in
                  title: lines: "/${
                    header "BEGIN" title
                  }/,/${
                    header "END" title
                  }/c${
                    lib.escape ["`"] (builtins.concatStringsSep ''\n'' lines)
                  }";
              in {
                checkDerivations = sed "CHECK DERIVATIONS" [
                  "The `checks.<SYSTEM>` attribute set contains the following"
                  "derivations:"
                  ""
                  "include::$check_derivations[]"
                ];

                moduleOptions = sed "MODULE OPTIONS" [
                  "=== Module Options"
                  ""
                  "include::$module_options[]"
                ];
              };
            in ''
              {
                check_derivations="$(mktemp)"

                awk \
                  '
                    /^==/ {
                      print \
                        "==" \
                        gensub( \
                          "\\.",
                          "${lib.dotfiles.homeManagerConfiguration.separator}",
                          "g" \
                        )

                      next
                    }

                    1
                  ' \
                  "${checkDerivations}" \
                  >"$check_derivations" &

                sed \
                  --in-place \
                  "${sed.checkDerivations}" \
                  user_documentation/checks/index.adoc &

                wait
              } &

              {
                module_options="$(mktemp)"

                awk \
                  '/^==/ { print "==" $0; next } 1' \
                  "${moduleOptions}" \
                  >"$module_options" &

                sed \
                  --in-place \
                  "${sed.moduleOptions}" \
                  user_documentation/index.adoc &

                wait
              } &

              wait

              asciidoctor-multipage \
                --attribute attribute-missing=warn \
                --destination-dir "${out}" \
                --failure-level INFO \
                index.adoc

              ${pkgs.html-minifier.meta.mainProgram} \
                --case-sensitive \
                --collapse-boolean-attributes \
                --collapse-inline-tag-whitespace \
                --collapse-whitespace \
                --conservative-collapse \
                --decode-entities \
                --input-dir "${out}" \
                --minify-css true \
                --minify-js true \
                --minify-urls true \
                --output-dir "${out}" \
                --preserve-line-breaks \
                --remove-attribute-quotes \
                --remove-comments \
                --remove-empty-attributes \
                --remove-empty-elements \
                --remove-optional-tags \
                --remove-redundant-attributes \
                --remove-script-type-attributes \
                --remove-style-link-type-attributes \
                --remove-tag-whitespace \
                --sort-attributes \
                --sort-class-name \
                --trim-custom-fragments
            '';

            name = "docs";

            nativeBuildInputs = with pkgs; [
              asciidoctor-with-extensions
              html-minifier
            ];

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
    # Due to the more reliable 'lib.mkMerge' function being unavailable, the
    # 'inputs.flakeUtils.lib.defaultSystems' expression and
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
            acc
            // (import ./home_configurations {
              inherit system;

              lib = pkgs.lib.extend (
                final: _:
                  import ./lib {
                    inherit inputs pkgs system;
                    lib = final;
                  }
              );
            })
        )
        {}
        inputs.flakeUtils.lib.defaultSystems;
    };
}
