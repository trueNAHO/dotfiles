{
  config,
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ../../agenix/homeManagerModules/default
    ../../homeManager/home/packages/rustup
    ../../homeManager/nixpkgs/config/allowUnfree
    ../../homeManager/programs/man
    ./autoCmd
    ./keymaps
    ./options
    ./plugins
    inputs.nixvim.homeManagerModules.nixvim
  ];

  options.modules.programs.nixvim.enable =
    lib.mkEnableOption "modules.programs.nixvim";

  config = lib.mkIf config.modules.programs.nixvim.enable {
    modules = {
      agenix.homeManagerModules.default.enable = true;

      homeManager = {
        home.packages.rustup.enable = true;
        nixpkgs.config.allowUnfree.enable = true;
        programs.man.enable = true;
      };
    };

    age.secrets.modulesProgramsNixvimPluginsCodeiumApiKey.file = plugins/codeium_api_key.age;
    home.shellAliases.n = pkgs.neovim.meta.mainProgram;

    programs.nixvim = {
      enable = true;

      globals = let
        leader = " ";
      in {
        mapleader = leader;
        maplocalleader = leader;
      };
    };
  };
}
