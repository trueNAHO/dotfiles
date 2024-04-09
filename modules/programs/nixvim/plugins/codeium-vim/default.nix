{
  config,
  lib,
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

    age.secrets.modulesProgramsNixvimPluginsCodeiumApiKey.file = ../codeium_api_key.age;

    # TODO: Replace the activation script with an upstream VIM plugin option for
    # setting the config path storing the API key, similar to the 'config_path'
    # option in https://github.com/Exafunction/codeium.nvim:
    # https://github.com/Exafunction/codeium.vim/issues/303.
    home.activation."modules.programs.nixvim" = let
      directory = "${config.xdg.dataHome}/.codeium";
    in
      lib.hm.dag.entryAfter ["writeBoundary"] ''
        mkdir --parents "${directory}"

        ln \
          --force \
          --symbolic \
          ${config.age.secrets.modulesProgramsNixvimPluginsCodeiumApiKey.path} \
          "${directory}/config.json"
      '';

    programs.nixvim.plugins.codeium-vim.enable = true;
  };
}
