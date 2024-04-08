{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.homeManager.home.packages.duf.enable =
    lib.mkEnableOption "modules.homeManager.home.packages.duf";

  config = lib.mkIf config.modules.homeManager.home.packages.duf.enable {
    home.packages = [pkgs.duf];
  };
}
