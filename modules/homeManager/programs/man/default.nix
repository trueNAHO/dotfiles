{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../../../programs/nixvim];

  options.modules.homeManager.programs.man.enable = lib.mkEnableOption "man";

  config = lib.mkIf config.modules.homeManager.programs.man.enable {
    modules.programs.nixvim.enable = true;
    programs.man.enable = true;
    home.sessionVariables.MANPAGER = "${pkgs.neovim.meta.mainProgram} +Man!";
  };
}
