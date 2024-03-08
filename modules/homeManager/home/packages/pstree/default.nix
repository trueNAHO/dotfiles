{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.pstree.enable =
    lib.mkEnableOption "pstree";

  config = lib.mkIf config.modules.homeManager.home.packages.pstree.enable {
    home.packages = [pkgs.pstree];
  };
}
