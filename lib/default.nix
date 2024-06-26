{
  inputs,
  lib,
  pkgs,
  system,
}: {
  dotfiles = {
    homeManagerConfiguration = {
      /*
      Creates a named and extensible default Home Manager configuration.

      # Type

      ```
      homeManagerConfiguration :: String -> AttrSet -> AttrSet
      ```

      # Arguments

      extraConfig
      : The Home Manager configuration to merge with the default.

      name
      : The `<NAME>` of the Home Manager configuration, defined by the
        `<SYSTEM>-<ACCESSIBILITY>-<NAME>` naming convention.

      # Examples

      ```nix
      homeManagerConfiguration "home-manager" {
        config.dotfiles.homeManager.programs.home-manager.enable = true;
        imports = [modules/homeManager/programs/home-manager];
      }
      => { home-manager = { ... }; }
      ```
      */
      homeManagerConfiguration = name: extraConfig: {
        ${name} = inputs.homeManager.lib.homeManagerConfiguration {
          inherit pkgs;

          extraSpecialArgs = {
            inherit inputs system;
            lib = lib.extend (_: _: inputs.homeManager.lib);
          };

          # The default 'config' attribute set is merged with the 'extraConfig'
          # argument by merging the default 'config' attribute set with
          # 'extraConfig.config', using 'mkMerge', and by merging the
          # non-'config' 'extraConfig' attributes with the merged 'config'
          # attribute, using the '//' operator. Excluding the
          # 'extraConfig.config' attribute from the '//' operation ensures that
          # the default 'config.home' attribute is not entirely overwritten by a
          # potential 'extraConfig.config.home' attribute, leveraging the same
          # benefits 'mkMerge' has over '//'.
          #
          # Due to the following error, the more straightforward implementation
          # of merging the default 'config' attribute set directly with
          # 'extraConfig', using 'mkMerge', is not used:
          #
          #     error: The option `home.stateVersion' is used but not defined.
          #
          # This error is most likely caused by the evaluation order implied the
          # 'mkMerge' function.
          #
          # For performance reasons, the simpler yet slower
          # 'lib.dotfiles.recursiveMerge' function is not used.
          modules = [
            (
              {config, ...}:
                {
                  config = lib.mkMerge [
                    {
                      home = {
                        homeDirectory = "/home/${config.home.username}";
                        stateVersion = "23.05";
                        username = "naho";
                      };
                    }

                    (extraConfig.config or {})
                  ];
                }
                // (builtins.removeAttrs extraConfig ["config"])
            )
          ];
        };
      };

      /*
      Prepends a prefix to each attribute set key returned by a list of files.

      # Type

      ```
      prependPrefix :: String -> [Path] -> AttrSet
      ```

      # Arguments

      files
      : The list of files returning attribute sets to which to prepend the
        prefix to.

      prefix
      : The prefix to prepend to each attribute set key.

      # Examples

      ```nix
      import ./a lib
      => { a = { ... }; }

      import ./b lib
      => { b = { ... }; }

      prependPrefix "public" [./a ./b]
      => { public-a = { ... }; public-b = { ... }; }
      */
      prependPrefix = prefix: files:
        lib.mapAttrs'
        (
          name:
            lib.nameValuePair
            "${prefix}${lib.dotfiles.homeManagerConfiguration.separator}${name}"
        )
        (builtins.foldl' (acc: file: acc // (import file lib)) {} files);

      /*
      The separator used to join the sections in the Home Manager configuration
      name.

      # Type

      ```
      separator :: String
      ```

      # Examples

      ```nix
      "<BEFORE>${separator}<AFTER>"
      => "<BEFORE>-<AFTER>"
      ```
      */
      separator = "-";
    };

    lib.hm.dag.entryBefore.writeBoundary = {
      /*
      Creates a consistent system requirement activation script based on a
      source, literal expression, and an optional documentation reference.

      # Type

      ```
      systemRequirement :: String -> String -> String -> AttrSet
      ```

      # Arguments

      documentation
      : The optional documentation reference. An empty string ignores this
        value.

      literalExpression
      : The literal Nix expression that should be included in the system
        configuration.

      src
      : The module requiring the system configuration.

      # Examples

      ```nix
      documentation = "https://nixos.org/nixos/options.xhtml#opt-services.easyeffects.enable"
      literalExpression = "programs.dconf.enable = true;"
      src = "dotfiles.homeManager.services.easyeffects"

      systemRequirement src literalExpression documentation
      => {
        after = [ ... ];
        before = [ ... ];
        data = "printf 'trace: INFO: dotfiles.homeManager.services.easyeffects: %s\\n' \"include 'programs.dconf.enable = true;' in the system configuration: https://nixos.org/nixos/options.xhtml#opt-services.easyeffects.enable\"\n";
      }

      systemRequirement src literalExpression ""
      => {
        after = [ ... ];
        before = [ ... ];
        data = "printf 'trace: INFO: dotfiles.homeManager.services.easyeffects: %s\\n' \"include 'programs.dconf.enable = true;' in the system configuration\"\n";
      }
      ```
      */
      systemRequirement = src: literalExpression: documentation: let
        string = "include '${literalExpression}' in the system configuration${
          lib.optionalString (documentation != "") ": ${documentation}"
        }";
      in
        lib.dotfiles.lib.hm.dag.entryBefore.writeBoundary.printf src string;

      /*
      Creates a consistent logging activation script based on a source and
      message.

      # Type

      ```
      printf :: String -> String -> AttrSet
      ```

      # Arguments

      src
      : The module initiating the activation script.

      message
      : The message to print.

      # Examples

      ```nix
      config.nixpkgs.config.allowUnfree = true

      let
        allowUnfree = toString config.nixpkgs.config.allowUnfree;
      in
        lib.dotfiles.lib.hm.dag.entryBefore.writeBoundary.printf
        "dotfiles.homeManager.nixpkgs.config.allowUnfree"
        "'nixpkgs.config.allowUnfree = ${allowUnfree};'";
      => {
        after = [ ... ];
        before = [ ... ];
        data = "printf 'trace: INFO: dotfiles.homeManager.nixpkgs.config.allowUnfree: %s\\n' \"'nixpkgs.config.allowUnfree = 1;'\"\n";
      }
      */
      printf = src: message:
        lib.hm.dag.entryBefore ["writeBoundary"] ''
          ${lib.getExe' pkgs.coreutils "printf"} \
            'trace: INFO: %s: %s\n' \
            "${src}" \
            "${message}"
        '';
    };

    /*
    Creates the HTML body for `notify-send` notifications based on a list of
    `name`-`value` pairs.

    # Type

    ```
    body :: [{ name :: String; value :: String; }] -> String
    ```

    # Arguments

    name
    : The title of the `value`.

    value
    : The content of the `name`.

    # Examples

    ```nix
    body [
      (lib.nameValuePair "Title 1" "Content 1")
      (lib.nameValuePair "Title 2" "Content 2")
    ]
    => "<u>Title 1:</u> Content 1\n<u>Title 2:</u> Content 2\n"
    ```
    */
    notifySend.body = lib.concatMapStrings (
      {
        name,
        value,
      }: ''<u>${name}:</u> ${value}\n''
    );

    /*
    Recursively merges a list of attribute sets.

    Unlike 'lib.mkMerge', this function actually returns a merged attribute set.

    # Type

    ```
    recursiveMerge :: [AttrSet] -> AttrSet
    ```

    # Throws

    Throws an error if elements to be merged have different types.

    # Examples

    ```nix
    recursiveMerge [
      {
        attrset = {
          attrset = {
            int = 0;
            list = [ 1 2 3 ];
          };
        };

        int = 4;
        list = [ 5 6 7 ];
      }
      {
        attrset = {
          attrset = {
            bool = false;
            int = 1;
          };
        };

        int = 1;
        list = [ 7 8 9 ];
      }
    ]
    => {
      attrset = {
        attrset = {
          bool = false;
          int = 1;
          list = [ 1 2 3 ];
        };
      };

      int = 1;
      list = [ 5 6 7 8 9 ];
    }

    recursiveMerge [
      { int = 0; }
      { int = null; }
    ]
    => error: Cannot merge different types: 'int' and 'null'
    ```
    */
    recursiveMerge = lib.fix (
      self:
        builtins.zipAttrsWith (
          _: values: let
            expectedType = lib.last valueTypes;

            findFirst =
              lib.findFirst
              (type: type != expectedType)
              null
              valueTypes;

            last = lib.last values;
            valueTypes = builtins.map builtins.typeOf values;
          in
            if findFirst != null
            then
              throw
              "Cannot merge different types: '${findFirst}' and '${expectedType}'"
            else if builtins.isAttrs last
            then self values
            else if builtins.isList last
            then lib.unique (builtins.concatLists values)
            else last
        )
    );
  };
}
