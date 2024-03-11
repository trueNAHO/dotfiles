{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [../../../homeManager/programs/man];
  options.modules.home.packages.dotfiles.enable = lib.mkEnableOption "dotfiles";

  config = lib.mkIf config.modules.home.packages.dotfiles.enable {
    modules.homeManager.programs.man.enable = true;

    home.packages = [
      (import ../../../../lib/derivations/man_page.nix {
        inherit pkgs;
        path = "docs";
      })
    ];
  };
}
