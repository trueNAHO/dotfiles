{
  config,
  lib,
  pkgs,
  ...
}: {
  options.dotfiles.homeManager.home.shellAliases.enable =
    lib.mkEnableOption "dotfiles.homeManager.home.shellAliases";

  config = lib.mkIf config.dotfiles.homeManager.home.shellAliases.enable {
    home.shellAliases = {
      c = "cd";
      cal = "${lib.getExe' pkgs.util-linux "cal"} --monday";
    };
  };
}
