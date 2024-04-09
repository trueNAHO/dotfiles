{
  config,
  lib,
  ...
}: {
  imports = [
    ../../../../agenix/homeManagerModules/default
    ../../../../homeManager/nixpkgs/config/allowUnfree
  ];

  options.modules.programs.nixvim.plugins.codeium-nvim.enable =
    lib.mkEnableOption "modules.programs.nixvim.plugins.codeium-nvim";

  config = lib.mkIf config.modules.programs.nixvim.plugins.codeium-nvim.enable {
    modules = {
      agenix.homeManagerModules.default.enable = true;
      homeManager.nixpkgs.config.allowUnfree.enable = true;
    };

    age.secrets.modulesProgramsNixvimPluginsCodeiumApiKey.file = ../codeium_api_key.age;

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
