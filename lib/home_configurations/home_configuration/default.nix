/*
Defines a default Home Manager configuration.

# Type

```
home_configuration :: {
  homeManagerConfiguration :: AttrSet;
  inputs :: AttrSet;
  name :: String;
  pkgs :: AttrSet;
  system :: String;
} -> AttrSet
```

# Arguments

homeManagerConfiguration
: The Home Manager configuration to merge with the default.

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

  homeManagerConfiguration = {
    config.modules.homeManager.programs.home-manager.enable = true;
    imports = [modules/homeManager/programs/home-manager];
  };

  name = "home-manager";
  system = "x86_64-linux";
}
=> { home-manager = { ... }; }
```
*/
{
  homeManagerConfiguration,
  inputs,
  name,
  pkgs,
  system,
}: {
  ${name} = inputs.homeManager.lib.homeManagerConfiguration {
    inherit pkgs;
    extraSpecialArgs = {inherit inputs system;};

    # The default 'config' attribute set is merged with the
    # 'homeManagerConfiguration' argument by merging the default 'config'
    # attribute set with 'homeManagerConfiguration.config', using 'mkMerge', and
    # by merging the non-'config' 'homeManagerConfiguration' attributes with the
    # merged 'config' attribute, using the '//' operator. Excluding the
    # 'homeManagerConfiguration.config' attribute from the '//' operation
    # ensures that the default 'config.home' attribute is not entirely
    # overwritten by a potential 'homeManagerConfiguration.config.home'
    # attribute, leveraging the same benefits 'mkMerge' has over '//'.
    #
    # Due to the following error, the more straightforward implementation of
    # merging the default 'config' attribute set directly with
    # 'homeManagerConfiguration', using 'mkMerge', is not used:
    #
    #     error: The option `home.stateVersion' is used but not defined.
    #
    # This error is most likely caused by the evaluation order implied the
    # 'mkMerge' function.
    modules = [
      (
        {config, ...}:
          {
            config = pkgs.lib.mkMerge [
              {
                home = {
                  homeDirectory = "/home/${config.home.username}";
                  stateVersion = "23.05";
                  username = "naho";
                };
              }

              homeManagerConfiguration.config
            ];
          }
          // (builtins.removeAttrs homeManagerConfiguration ["config"])
      )
    ];
  };
}
