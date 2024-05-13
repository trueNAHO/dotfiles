{
  config,
  lib,
  ...
}: {
  imports = [
    ../../../../agenix/homeManagerModules/default
    ../../../../homeManager/nixpkgs/config/allowUnfree
  ];

  options.dotfiles.programs.nixvim.plugins.codeium-nvim.enable =
    lib.mkEnableOption "dotfiles.programs.nixvim.plugins.codeium-nvim";

  config =
    lib.mkIf
    config.dotfiles.programs.nixvim.plugins.codeium-nvim.enable {
      dotfiles = {
        agenix.homeManagerModules.default.enable = true;
        homeManager.nixpkgs.config.allowUnfree.enable = true;
      };

      age.secrets.modulesProgramsNixvimPluginsCodeiumApiKey = {
        file = ../codeium_api_key.age;
      };

      programs.nixvim.plugins.codeium-nvim = {
        configPath.__raw = ''
          vim.fn.expand(
            "${config.age.secrets.modulesProgramsNixvimPluginsCodeiumApiKey.path}"
          )
        '';

        enable = true;
      };
    };
}
