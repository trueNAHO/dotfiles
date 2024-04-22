{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../../../agenix/homeManagerModules/default
    ../../../../homeManager/nixpkgs/config/allowUnfree
  ];

  options.modules.programs.nixvim.plugins.codeium-vim.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.codeium-vim";

  config = lib.mkIf config.modules.programs.nixvim.plugins.codeium-vim.enable {
    modules = {
      agenix.homeManagerModules.default.enable = true;
      homeManager.nixpkgs.config.allowUnfree.enable = true;
    };

    age.secrets.modulesProgramsNixvimPluginsCodeiumApiKey = {
      file = ../codeium_api_key.age;
    };

    # Unlike 'codeium.nvim' [1], 'codeium.vim' [2] does not interface path to
    # the configuration file containing the API key. This activation script
    # symlinks the decrypted agenix file to the expected location.
    #
    # TODO: Replace this activation script with an upstream 'codeium.vim' [2]
    # option interfacing the path to the configuration file containing the API
    # key. [3]
    #
    # [1]: https://github.com/Exafunction/codeium.nvim
    # [2]: https://github.com/Exafunction/codeium.vim
    # [3]: https://github.com/Exafunction/codeium.vim/issues/303
    home.activation."modules.programs.nixvim" =
      lib.hm.dag.entryAfter
      ["writeBoundary"]
      (
        lib.getExe (pkgs.writeShellApplication {
          name = "modules-programs-nixvim";
          runtimeInputs = [pkgs.coreutils];

          text = let
            directory = "${config.xdg.dataHome}/.codeium";
          in ''
            mkdir --parents "${directory}"

            ln \
              --force \
              --symbolic \
              "${config.age.secrets.modulesProgramsNixvimPluginsCodeiumApiKey.path}" \
              "${directory}/config.json"
          '';
        })
      );

    programs.nixvim.plugins.codeium-vim.enable = true;
  };
}
