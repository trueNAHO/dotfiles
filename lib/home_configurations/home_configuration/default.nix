/*
Defines a default Home Manager configuration.

# Type

```
home_configuration :: {
  homeManagerConfig :: AttrSet;
  imports :: [Path];
  inputs :: AttrSet;
  name :: String;
  pkgs :: AttrSet;
  system :: String;
} -> AttrSet
```

# Arguments

homeManagerConfig
: The Home Manager configuration to merge with the default.

imports
: The `imports` value of the Home Manager configuration module.

inputs
: The attribute set of all the dependencies of the flake.

name
: The `<NAME>` of the Home Manager configuration, defined by the
  `<SYSTEM>-<ACCESSIBILITY>-<SCOPE>-<NAME>` naming convention.

pkgs
: The Nixpkgs attribute set.

system
: The system architecture.

# Examples

```nix
home_configuration {
  inherit inputs pkgs;

  homeManagerConfig.modules.homeManager.programs.home-manager.enable = true;
  imports = [modules/homeManager/programs/home-manager];
  name = "home-manager";
  system = "x86_64-linux";
}
=> { home-manager = { ... }; }
```
*/
{
  homeManagerConfig,
  imports,
  inputs,
  name,
  pkgs,
  system,
}: {
  ${name} = inputs.homeManager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = {inherit inputs system;};

    modules = [
      ({config, ...}: {
        inherit imports;

        config = pkgs.lib.mkMerge [
          {
            home = {
              homeDirectory = "/home/${config.home.username}";
              stateVersion = "23.05";
              username = "naho";
            };
          }

          homeManagerConfig
        ];
      })
    ];
  };
}
